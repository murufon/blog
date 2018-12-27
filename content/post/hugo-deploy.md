---
title: "Hugoのデプロイ"
date: 2018-12-27T00:20:37+09:00
draft: false
tags: ["hugo"]
categories: ["hugo"]
---

GitHub Pagesを使って作ったサイトを公開してみたいと思います

リポジトリ名や公開するフォルダによっていくつかやり方がありますが、独自ドメインにする際に都合がいいので今回はUser Pagesとしてデプロイしてみます
User Pagesは`https://<USERNAME>.github.io`というURLでアクセスできるようにするやり方で、ドメインと同名のリポジトリを作成する必要があります

Hugo公式がわかりやすくやり方を書いてくれているのでそれに沿ってやってみます
https://gohugo.io/hosting-and-deployment/hosting-on-github/
リポジトリ名などは適宜読み替えてください

# GitHub Pagesに公開する
- hugoのプロジェクト用のリポジトリを作成します。ここでは`hugo-blog`としました。このhugoのファイル一式をこのリポジトリにいれておきます
- `<USERNAME>.github.io`という名前でリポジトリを作る。自分の場合`murufon.github.io`です
- `git clone https://github.com/murufon/hugo-blog.git && cd hugo-blog`
- `hugo server`でサーバーを立ち上げ、`http://localhost:1313`で動作を確認します
- ちゃんと動作していたら
  - Ctrl+Cで止めて
  - `rm -rf public`で一旦`public`ディレクトリを削除します
- `git submodule add -b master https://github.com/murufon/murufon.github.io.git public`

最後のコマンドについて
`hugo`コマンドでサイトをビルドすると`public`にファイルが生成されます。そこで`public`フォルダだけ別のリポジトリにすることで分けて管理することができます(サブモジュール)。

あとは`config.toml`の`baseURL`を書き換えてあげればいい感じ(この公開方法だと`/`がトップだから変えなくても一応動きそう？)
```toml
baseURL = "https://murufon.github.io/"
```

# デプロイのスクリプト化
基本は公式ドキュメントにあるスクリプトのままです
`hugo-blog`をcommit/pushするコードを加えました
以下を`deploy.sh`として作成
```bash
#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..

# Commit hugo project
git add .
git commit -m "$msg"
git push origin master
```
`chmod +x deploy.sh`で実行権を与えてあげるのを忘れずに
これで`./deploy`でデプロイしてくれるようになる

リポジトリ名を`<USERNAME>.github.io`にすると特に設定しなくても自動的にgithub pagesに公開されるっぽい？(要確認)
実際にデプロイしてみて`https://<USERNAME>.github.io/`にアクセスしてみて正しく表示されれば成功
pushしてから反映まで少し時間がかかる場合があるので注意

# 独自ドメインの設定
## DNS設定をする
サービスによって設定方法は違うので各マニュアルを参照
`blog.kaio.ga CNAME murufon.github.io`

## GitHub側の設定
`static/`に`CNAME`という名前のテキストファイルを作成する(拡張子なし)。中身は設定したいカスタムドメインのみ
hugoでビルドすると公開サイトのリポジトリのルートにCNAMEが置かれる
github pagesはルートのCNAMEを見て独自ドメインの設定を判断しているらしい
これをpushしてしばらくすると`murufon.github.io`リポジトリのSettings→GitHub Pages→Enforce HTTPSが設定可能になるので設定しておく

# 記事作成のスクリプト化
どうせなら新規記事作成もスクリプトにまとめます
以下のファイルを`new.sh`として作成し、`chmod +x new.sh`
```bash
#!/bin/bash

if [ $# -eq 1 ]; then
  # $ ./new.sh atricleName
  articlename=$1
else
  # $ ./new.sh
  read -p 'Please input article name: ' articlename
fi
hugo new post/$articlename.md

# open this project wiht Atom
atom ./ && atom ./content/post/$articlename
```
`./new.sh <ARTICLE NAME>`と叩くと新しくファイルを作ってくれます
`./new.sh`と叩くと記事名を聞いてファイル作ってくれます
ファイル作った後Atomで開いてくれます
`atom`コマンドをインストールしていない場合はMacの場合はAtomのメニューのAtom→Install Shell Commandsからインストール