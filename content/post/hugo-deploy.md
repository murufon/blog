---
title: "Hugoのデプロイ"
date: 2018-12-27T00:20:37+09:00
draft: false
tags: ["hugo"]
categories: ["hugo"]
---

GitHub Pagesを使って作ったサイトを公開してみたいと思います
User/Organization PagesではなくProject Pagesとしてデプロイします
Hugo公式がわかりやすくやり方を書いてくれているのでそれに沿ってやってみます
https://gohugo.io/hosting-and-deployment/hosting-on-github/

# 公開するディレクトリの変更
github pagesではmasterブランチの/docsディレクトリを公開する方法とgh-pagesというブランチを公開する方法があります。今回は前者でやります

`config.toml`に追記する
```toml
publishDir = "docs"
```
`hugo`コマンドでビルドしてみて`/docs`ディレクトリに生成されるかテスト

今まで使っていたpublicディレクトリを削除します
```bash
rm -rf public
```

# githubにpushしてみる
`https://murufon.github.io/blog/`は適宜読み替えてください
`config.toml`の`baseURL`を`"https://murufon.github.io/blog/"`に書き換える
```bash
git init
git add .
git commit -m "first commit"
git remote add origin https://github.com/murufon/blog.git
git push -u origin master
```

setting→GitHub Pages→Sourceから`master branch /docs folder`を選択→Save
即座に反映されるわけではないので少し待ってから`Your site is ready to be published at https://murufon.github.io/blog/`のところから飛んでみて表示されれば成功