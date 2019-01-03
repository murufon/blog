---
title: "Dockerfileで対話式のコマンドを扱う"
date: 2019-01-02T22:40:48+09:00
draft: false
tags: ["Docker","Dockerfile"]
categories: ["Docker"]
---

インストールの時にインストールディレクトリを聞かれたり何かに同意したりといったやりとりを対話式でできるコマンドがある
そういうコマンドは便利な反面Dockerfileで扱うのは面倒である

そんなときのやり方メモ

## -yオプション
コマンドによっては-yコマンドで対応できる場合がある
例えば`apt-get install`とか
```bash
apt-get install -y vim
```

## yesコマンド
`yes`コマンドはひたすら`y`を出すコマンド
入力が`yes`だけでいいならこれをパイプで渡してあげれば良い
複数回の入力が必要でも
```bash
yes | sh install.sh
```

## expectコマンド
ちゃんと条件分岐させたいときはexpectコマンドを使う
出力に合わせて入力を返すことができる
タイムアウト時間やexitコードの設定もできる
コマンドが長くなりがちなので別ファイルに分けてビルドのときに渡してあげるようにしたほうがよさそう

## 標準入力を使う
やっぱりシェルの機能使うのがシンプルで楽
一行だけなら
```bash
echo "yes" | sh install.sh
```
複数行なら
例えば以下のように入力したいものを改行して並べた`inputs.txt`を用意して
```txt
yes
no

no
yes
/path/to/installdir
　
```
こう
```bash
sh install.sh < inputs.txt
```
大抵の場合はEnter(Return)で文字列を送る必要があるので最後に改行を忘れないようにする
ただEnterだけでよい場合は空行にするとよい