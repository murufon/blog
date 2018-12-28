---
title: "Raspberry Piのセットアップ(Raspbian)"
date: 2018-12-28T17:22:12+09:00
draft: false
tags: ["Raspberry Pi","自宅サーバー"]
categories: ["Raspberry Pi"]
---

Raspberry Pi 3 をセットアップしたときの手順と参考にしたリンクのまとめ

## Raspbianのインストール
raspbian日本のミラーサイト - Qiita
https://qiita.com/tukiyo3/items/c8555eacb67466b81bc8

SDカードへの書き込みはEtcher https://www.balena.io/etcher/

## 初期設定
Raspberry Piをディスプレイ・キーボード・マウス無しの三重苦でもセットアップする方法 - karaage. [からあげ]
http://karaage.hatenadiary.jp/entry/2015/07/15/080000

ちなみに、↑のサイトではネットワーク内のIPアドレスを一覧表示させる方法でやっているが、Raspberry Piには初めからホスト名が設定されているので、IPアドレスを調べなくてもssh接続できる場合がある
```bash
ssh pi@raspberrypi.local
```

sshでのアクセスが可能になったら、
```bash
sudo raspi-config
```
で各種設定をしておくと良い

## SDカードでの設定
ラズベリーパイには従来のBIOSがないため、通常はBIOSを使用して設定および設定されるさまざまなシステム構成パラメータが「config.txt」というテキストファイルに保存される。
/boot/config.txtはARMコアが初期化される前にGPUによって読み取られる。
/boot/config.txtの説明↓
https://elinux.org/RPiconfig 

## 外部から接続するための設定

### ipアドレスの固定
固定IPアドレスの設定（Wi-Fi（無線LAN）の場合）
http://www.hiramine.com/physicalcomputing/raspberrypi3/wlan_howto.html

固定IPアドレスの設定（有線LANの場合）
https://www.hiramine.com/physicalcomputing/raspberrypi3/setup_staticip.html

今回は以下のように設定しました
```bash
interface eth0
static ip_address=192.168.1.50/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
```
設定した後はインターフェイスの再起動か本体の再起動を

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
HDDのみでブートまでしてしまう方法もあるようだが、今回はブートはSDで

(参考)
Raspberry PiをUSB(HDD)で起動させる
https://jyn.jp/raspberrypi-usb-boot/

`/dev/sda3`は各自読み替えてください


```bash
# インストールするパーティションがどこにマウントされているか探す
sudo fdisk -l
# アンマウントする
umount /dev/sda3
# フォーマットする
sudo mkfs.ext4 /dev/sda3
# マウントする
sudo mount -t ext4 -o defaults /dev/sda3 /mnt
# 全データをコピーする
sudo rsync -ax --progress / /mnt
# インストール先パーティションのPARTUUIDを確認する
ls -l /dev/disk/by-partuuid/
# HDD上の/etc/fstabを開き/のPARTUUIDを先ほど確認したPARTUUIDに変更する
sudo vim /mnt/etc/fstab
# root=PARTUUID=の値を変更する
sudo vim /boot/cmdline.txt
# 再起動する
sudo reboot now
# 容量を見て起動ディスクが変更されていたらOK
df -h
```

## セキュリティやログインの設定
sshのポート変更とかssh公開鍵認証とか

ラズパイの最低限のセキュリティー設定 | Feijoa.jp
http://www.feijoa.jp/laboratory/raspberrypi/minimumSecurity/