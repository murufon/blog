---
title: "Gitのブランチをリポジトリとして独立させる"
date: 2019-03-13T09:57:32+09:00
draft: false
tags: ["Git"]
categories: ["Git"]
---

`old-repo`というリポジトリの`some-branch`というブランチを`new-repo`というリポジトリとして独立させたいとする
まず`new-repo`という名前で空のリポジトリを作っておく

## リモートのURLの変更

今のremote origin url
```
git config remote.origin.url
```
新しいURLにする
```
git config remote.origin.url <new-repoのURL>
```

## ローカルのmasterブランチを削除する
ローカルブランチ一覧
```
git branch
```
ブランチを削除する
```
git branch --delete master
```
ブランチの名前をmasterにする
```
git branch -m some-branch master
```
