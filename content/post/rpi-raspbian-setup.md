---
title: "Raspberry Piのセットアップ(Raspbian)"
date: 2018-12-28T17:49:25+09:00
lastmod: 2018-12-28T17:49:25+09:00
draft: false
tags: ["Raspberry Pi","自宅サーバー"]
categories: ["Raspberry Pi"]
---

murufonがRaspberry Pi 3 をセットアップした手順と参考にしたリンクのまとめ

## Raspbianのインストール
raspbian日本のミラーサイト - Qiita
https://qiita.com/tukiyo3/items/c8555eacb67466b81bc8

## 初期設定
Raspberry Piをディスプレイ・キーボード・マウス無しの三重苦でもセットアップする方法 - karaage. [からあげ]
http://karaage.hatenadiary.jp/entry/2015/07/15/080000

## SDカードでの設定
ラズベリーパイには従来のBIOSがないため、通常はBIOSを使用して設定および設定されるさまざまなシステム構成パラメータが「config.txt」というテキストファイルに保存される。
/boot/config.txtはARMコアが初期化される前にGPUによって読み取られる。
/boot/config.txtの説明↓
https://elinux.org/RPiconfig 


## 外部から接続するための設定

### ipアドレスの固定
固定IPアドレスの設定（Wi-Fi（無線LAN）の場合）
http://www.hiramine.com/physicalcomputing/raspberrypi3/wlan_howto.html

### ポートの開放
RT-500KI ポート開放設定の説明
https://www.akakagemaru.info/port/rt500ki-portfw.html

## Dockerとdocker-composeの導入
Raspberry PiにDockerを入れる - Qiita
https://qiita.com/hisurga/items/7aca7484ac5bfd084294

Raspberry Pi用docker-composeの構築 - Qiita
https://qiita.com/tkyonezu/items/ceaaf41924df39254058

(参考)
Raspberry PiにDocker ComposeでownCloudを導入する - さやかちゃんドットネット
http://shira.hatenadiary.jp/entry/2018/05/14/145228

## USBから外付けHDDで起動させる
DockerでいろいろするにはSDカードでの起動では不安だった
HDDのみでブートまでしてしまう方法もあるようだが、今回は不要と判断し、以下のURLのように設定

Raspberry PiをUSB(HDD)で起動させる
https://jyn.jp/raspberrypi-usb-boot/

## セキュリティやログインの設定
sshのポート変更とかssh公開鍵認証とか

ラズパイの最低限のセキュリティー設定 | Feijoa.jp
http://www.feijoa.jp/laboratory/raspberrypi/minimumSecurity/