---
title: "RaspberryPiにMailuをセットアップする"
date: 2018-12-28T17:49:23+09:00
draft: true
tags: ["Raspberry Pi","mailu","自宅server"]
categories: ["Raspberry Pi"]
---

Raspberry piでMailuをdocker-composeを使ってセットアップする
公式のセットアップを参考に

Docker Compose setup — Mailu, Docker based mail server
https://mailu.io/1.5/compose/setup.html

mailuがデータを保存するためのディレクトリを用意する。デフォルトでは`/mailu`
```bash
sudo mkdir /var/lib/mailu
cd /var/lib/mailu
```

初期設定ファイルをダウンロードする

Raspberry Pi用のリポジトリがあるのでそこから拝借します
https://github.com/MFAshby/Mailu/tree/master

```bash
sudo git clone https://github.com/MFAshby/Mailu.git .
sudo cp docker-compose.yml.sample docker-compose.yml
sudo cp .env.sample .env
```

.envを編集

設定項目は以下を参照
https://mailu.io/1.5/configuration.html

SECRET_KEYをランダムな16文字の文字列に変更
生成には以下を利用できる https://duckduckgo.com/?q=password+16

DOMAIN kaio.ga
HOSTNAMES mail.kaio.ga

SITENAME mail.kaio.ga
WEBSITE https://mail.kaio.ga

docker-compose.yml の編集
ポート

権限を与える
```bash
sudo chmod -R 777 mailu/
```

証明書の設定
[MyDNSで設定したドメインでLet's Encryptの証明書を取得する]({{< relref "rpi-mydns-letsencrypt" >}})で取得した証明書を使用
シンボリックリンクを貼るだけではコンテナ内から元ファイルを参照できないらしく失敗した
cpでコピーしているが、証明書を更新するたびにこのコマンドを打たなければいけないので他の方法あったら教えてください
<s>sudo ln -s /etc/letsencrypt/live/kaio.ga/fullchain.pem /var/lib/mailu/certs/cert.pem</s>
<s>sudo ln -s /etc/letsencrypt/live/kaio.ga/privkey.pem /var/lib/mailu/certs/key.pem</s>
```bash
sudo cp /etc/letsencrypt/live/kaio.ga/fullchain.pem /var/lib/mailu/certs/cert.pem
sudo cp /etc/letsencrypt/live/kaio.ga/privkey.pem /var/lib/mailu/certs/key.pem

```

docker-compose run --rm admin python manage.py admin root kaio.ga password