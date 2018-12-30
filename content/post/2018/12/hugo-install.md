---
title: "Hugoのインストール"
date: 2018-12-26T23:30:53+09:00
draft: false
tags: ["Hugo"]
categories: ["Hugo"]
---


## hugoとは
https://gohugo.io/
静的なサイトをつくるフレームワークで、Go言語で書かれている
Markdownで各ページを書いてそれをHTMLに変換(ビルド)し、それを公開する
事前にHTMLを生成するのでWordpressみたいにデータベースがいらないのでgithub pagesとかで公開できちゃう
他の静的サイトジェネレーターと比べてビルドが圧倒的に早いらしい

## テーマ
公式がテーマを一覧形式で出してくれている
https://themes.gohugo.io/

公式に採用されていない先人の自作テーマもググれば出てくると思う

### 気になったテーマ
- https://themes.gohugo.io/potato-dark/
- https://themes.gohugo.io/steam/
- https://themes.gohugo.io/hugo-theme-minos/
- https://themes.gohugo.io/hugo-theme-even/
- https://themes.gohugo.io/kiss/
- https://themes.gohugo.io/hugo-kiera/

今回はevenを選択


## セットアップ
https://gohugo.io/getting-started/quick-start/
quick startを見ながらセットアップしてみる

インストールとサイト作成
```bash
brew install hugo
hugo version
hugo new site hugo-blog
```

テーマとか設定とか
今回はテーマはevenで進めます
`config.toml`についてはテーマごとに違うので各テーマのREADMEを参照
```bash
cd hugo-blog
git clone https://github.com/olOwOlo/hugo-theme-even themes/even
cp themes/even/exampleSite/config.toml .
```

新規ページ作成
evenではpostsの代わりにpostを使うらしいので注意
```bash
hugo new post/my-first-post.md
# とりあえずHello World！！
cat << EOF >> content/post/my-first-post.md
Hello World
EOF
```
サーバーを立ち上げる
```bash
hugo server -D
```
localhost:1313で確認
