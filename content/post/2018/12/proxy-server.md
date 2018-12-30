---
title: "プロキシサーバー"
date: 2018-12-28T17:49:25+09:00
draft: false
tags: ["proxy","自宅server","Raspberry Pi"]
categories: ["Raspberry Pi"]
---
# プロキシサーバーの設定

自宅のraspberrypiにMyDNS+Let'sEncryptでhttps対応のサーバーを立てましたが、自宅からはMyDNSで登録したドメインでraspberrypiにアクセスできずテストの際困りました。
そこでプロキシサーバーを経由することで自宅のネットワーク内からでも外部からと同じように登録したドメインからraspberrypiにアクセスできるようにしました。
そのときのメモ。

# プロキシサーバーを探す

フリーのプロキシサーバーを探すには以下のサイトが有名みたいです。
CyberSyndrome - The Proxy Search Engine ( http://www.cybersyndrome.net/ )
例えば日本のプロキシサーバーを探したかったらJPで検索すればOKです。