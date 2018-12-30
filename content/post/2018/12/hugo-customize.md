---
title: "Hugoのカスタマイズ"
date: 2018-12-26T23:43:53+09:00
draft: false
tags: ["Hugo"]
categories: ["Hugo"]
---

自分が設定した項目のメモ

## 各種設定
基本的な設定は`config.toml`を書き換えることで設定できるようになっている
テーマごとに設定項目に異なる部分があるので各テーマのREADMEやexampleを見ながら書き換える

hugo全体に共通の設定は以下より
https://gohugo.io/getting-started/configuration/
テーマevenの設定項目は以下とか`themes/even/exampleSite/config.toml`とかを参照
https://themes.gohugo.io/hugo-theme-even/
```bash
vim config.toml
```

### markdownの設定
`config.toml`に以下を追記する
```toml
[blackfriday]
  fractions = false
  extensions = ["hardLineBreak"]
```

## テーマをいじる
### フォントを変更
`themes/even/src/css/_variables.scss`の`$global-serif-font-family`から`STHeiti`を抜く
`$logo-font-family`を`$global-serif-font-family`と同じものにする

<!-- ## h1,h2,h3...のフォントサイズを変更する
h1とh2の見分けがつきにくかったのでh2をh3のサイズに、h3をh4のサイズに...
`themes/even/src/css/_variables.scss`の`$global-headings`を以下に変更
```scss
  h1: 26px,
  h2: 20px,
  h3: 16px,
  h4: 14px,
  h5: 14px,
  h6: 14px
``` -->

### ビルドする
テーマのファイルを変更したらビルドする
```bash
cd ./themes/even/
yarn install
yarn build
```

