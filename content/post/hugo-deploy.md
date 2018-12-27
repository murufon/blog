---
title: "Hugonのデプロイ"
date: 2018-12-27T00:20:37+09:00
draft: true
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

