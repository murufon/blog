---
title: "MyDNSで設定したドメインでLet's Encryptの証明書を取得する"
date: 2018-12-28T17:43:39+09:00
lastmod: 2018-12-28T17:43:39+09:00
draft: false
tags: ["Raspberry Pi","自宅server","letsencrypt","mydns"]
categories: ["Raspberry Pi"]
---

## Nginx で PHP を使う設定
これやらないとMyDNSのリポジトリでの証明書取得はできなさそう

Raspberry Pi にWebサーバ入れてphp動かす - Qiita
https://qiita.com/Brutus/items/27525deedb0eea1b35b8
上記サイトの通り。ただし、php7.0-fpmに加えてphp7.0-mbstringをinstallする



## 証明書の取得

MyDNS公式リポジトリ( https://github.com/disco-v8/DirectEdit/ )のREADMEを参照

ワイルドカードの証明書を取得するにはcertbotの0.22以上が必要らしいが、現時点では`apt-get install`でバージョン0.10.2までしかはいらなかったのでGitから取ってくる

```bash
git clone https://github.com/certbot/certbot.git ~/certbot
```
READMEにしたがってMyDNSのアカウントの設定等をファイルに書き込む

READMEのコマンドの該当箇所を変更したら僕の環境では以下のようになった
```bash
sudo ~/certbot/certbot-auto certonly --manual \
--preferred-challenges=dns \
--manual-auth-hook /var/www/html/DirectEdit-master/txtregist.php \
--manual-cleanup-hook /var/www/html/DirectEdit-master/txtdelete.php \
-d kaio.ga -d *.kaio.ga \
--server https://acme-v02.api.letsencrypt.org/directory \
--agree-tos -m murufon2@gmail.com \
--manual-public-ip-logging-ok
```

成功したら以下のようなメッセージがでてくるはず
```bash
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/kaio.ga/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/kaio.ga/privkey.pem
   Your cert will expire on 2018-12-21. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot-auto
   again. To non-interactively renew *all* of your certificates, run
   "certbot-auto renew"
 ```
 
 ## 証明書を自動更新するための設定
 `certbot_renew.sh`を作成
```bash
$ vi certbot_renew.sh
```

環境によってsudo外したりcertbot-autoのpath書き換えたりしてください
証明書を更新したときに再起動しなければいけないサービスもここで再起動してあげます
```bash:certbot_renew.sh
#!/bin/bash

# 証明書の更新
sudo ~/certbot/certbot-auto renew
# nginxの再起動
sudo nginx -s reload
```

実行権限の付与

```bash
$ chmod 755 certbot_renew.sh
```

### cronに登録
毎週土曜日の午前3時に証明書を更新する場合
`/home/pi/certbot_renew.sh`にシェルを置いている場合
```bash
$ crontab -e

00 3 * * 6 /home/pi/certbot_renew.sh
```