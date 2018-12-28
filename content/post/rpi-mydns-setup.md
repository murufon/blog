---
title: "Raspberry PiからMyDNSを使う"
date: 2018-12-28T17:40:16+09:00
lastmod: 2018-12-28T17:40:16+09:00
draft: false
tags: ["Raspberry Pi","mydns","自宅server"]
categories: ["Raspberry Pi"]
---

基本的にMyDNSのサイト( https://www.mydns.jp/ )のHOW TO USEに沿ってます

## MyDNSでの事前準備

MyDNSに登録する
HOW TO USEなどを見ながらDNSレコードを設定する

## MyDNSへIPを通知するスクリプトの作成

明示的にIPv4とIPv6の両方通知するようにしました

`mydns_noticeip.sh`を作成
```bash
$ vi mydns_noticeip.sh
```

以下をコピペしてMasterIDとPasswordは置き換えてください
```bash:mydns_noticeip.sh
#!/bin/bash

MasterID="mydns123456"
Password="xxxxxxxxxxx"

wget -O - "http://${MasterID}:${Password}@ipv4.mydns.jp/login.html"
wget -O - "http://${MasterID}:${Password}@ipv6.mydns.jp/login.html"
```

実行権限の付与

```bash
$ chmod 755 mydns_noticeip.sh
```

送信確認

```bash
$ ./mydns_noticeip.sh
```
以下のようなものが返ってくればOKです(IPv4の分とIPv6の分で2回出ます)
```bash
<html>
<head>
<title>Free Dynamic DNS (DDNS) for Home Server and VPS etc  | MyDNS.JP</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<LINK href="./site.css" rel=stylesheet type=text/css>

</head>
<BODY BGCOLOR="#FFFFFF"
      TEXT="#304040"
      leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
>
Login and IP address notify OK.<BR>
...
```

## cronへの登録
5分おきに通知する場合
`/home/pi/mydns_noticeip.sh`にシェルを置いている場合
```bash
$ crontab -e

*/5 * * * * /home/pi/mydns_noticeip.sh
```

実際に通知できているかはMyDNSの最新IP通知日時を確認すればわかります