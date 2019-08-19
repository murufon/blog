---
title: "Galleria XTにUbuntu18.04を入れた話"
date: 2019-08-20T00:14:44+09:00
draft: false
tags: ["linux"]
categories: ["linux"]
---

GALLERIA XTにUbuntu18.04日本語Remixをインストールしたときの話

USBからUbuntuを起動してインストーラーに遵いながらエラーが出たら順に解決していく方針です。これが最適方法かはわかりません。

## Windows10の高速スタートアップを無効にする
Ubuntuのブートと干渉すると怖いので高速スタートアップを無効にしておく

コントロールパネル→ハードウェアとサウンド→電源オプション→電源ボタンの動作を選択する（システム設定）→電源ボタンの定義とパスワード保護の有効化「現在利用可能でない設定を変更します」→シャットダウン設定の「高速スタートアップを有効にする（推奨）」→変更の保存

## イメージをダウンロードする
https://www.ubuntulinux.jp/News/ubuntu1804-ja-remix からUbuntu18.04日本語Remixをダウンロード

## RufusでブータブルUSBを作る
Rufusのダウンロードはここから https://rufus.ie/

設定そのままインストールしようとすると
```
Failed to open \EFI\BOOT\mmx64.efi - Not Found
Failed to load image \EFI\BOOT\mmx64.efi: Not Found
Failed to start MokManager: Not Fond
Something has gone seriously wrong: import_mok_state() failed
```
というエラーが出てしまった
https://askubuntu.com/questions/1085550/cant-install-ubuntu-18-10-on-xps-15-efi-boot-mmx64-efi-not-found によると`/efi/boot`内の`grubx64.efi`をコピーして`mmx64.efi`というファイル名にすると良いらしい

Rufusの設定の「保存領域のサイズ」を1GBほどにする(grubx64.efiを複製できるくらいのサイズがあれば問題ないと思う)。ブータブルUSB作成後、`/efi/boot/grubx64.efi`を複製して`/efi/boot/mmx64.efi`をつくる

途中ポップアップでISOかDDかと聞かれるが、ISOモードだとうまくいかないのでDDモードで作成した方が良いらしい(もしかしたらISOモードでもうまくいくのかもしれない。未検証)

パーティション分割はUbuntuのインストール中にインストーラー内で行なった(他の環境では事前に手動で分けておかなければいけないという情報もあった)

## bootまわりのエラー解決(boot-repair)
上記の作業によりインストールは進んだが、また途中でエラーが出てしまった

```
'grub-efi-amd64-signed'パッケージを/target/にインストールするのに失敗しました。GRUBブートローダなしでは、インストールしたシステムは起動しません。
```

http://www.lab-ssk.com/how-to-fix-grub-installation-failed-error-by-boot-repair-when-installing-chaletos-in-uefi-environment を参考にboot-repairに修復してもらった

boot-repairの起動時にsecure bootをオフにするよう言われたのでオフにしておくこと。ASUSマザーの場合はBIOSの以下の場所で設定できる
Advanced Mode→Boot→Secure Boot→OS Type→Other OSに

boot-repairに言われるがままにコマンドを打っていく。具体的には以下のコマンドを実行した
```
sudo chroot "/mnt/boot-sav/sdb5" dpkg --configure -a
sudo chroot "/mnt/boot-sav/sdb5" apt-get install -fy
sudo chroot "/mnt/boot-sav/sdb5" apt-get purge -y grub*-common grub-common:i386 shim-signed
sudo chroot "/mnt/boot-sav/sdb5" apt-get install -y grub-efi-amd64-signed shim-signed linux-headers-generic linux-signed-generic
```

実行後boot-repairが以下のメッセージを出してきたので再起動して完了
```
ブートが正常に修復されました。

次のURLを紙に書き記してください:
http://paste.ubuntu.com/p/X3g6Sp6DXT/


万が一、まだブートに問題がある場合は、このURLを次のメールアドレスに送ってください:
boot.repair@gmail.com またはあなたの好みのフォーラムに。

今すぐコンピューターを再起動することができます。
BIOSでsdb1/EFI/ubuntu/shimx64.efiファイルから起動するようにすることを忘れないでください。

コンピューターを再起動してWindowsが直接起動した場合は、BIOSでブートの順序を変更してみてください。
BIOSでブートの順序を変更できない場合は、Windowsブートローダーのデフォルトのブートエントリを変更してください。
例えばWindowsを起動した後、管理者権限で次のコマンドを実行します:
bcdedit /set {bootmgr} path \EFI\ubuntu\shimx64.efi
```

## (おまけ)TP-Linkの無線LAN子機T2Uのドライバをインストール

https://github.com/aircrack-ng/rtl8812au のREADMEにしたがってスクリプトを実行したらT2Uを認識してくれた
