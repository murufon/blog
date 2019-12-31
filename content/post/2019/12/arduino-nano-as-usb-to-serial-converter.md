---
title: "Arduino NanoをUSBシリアル変換器として使う"
date: 2019-12-31T12:29:15+09:00
draft: false
tags: ["arduino","電子工作"]
categories: ["電子工作"]
---

CH380Gをシリアル変換器として搭載している安価なArduino Nanoを単体のUSBシリアル変換器として使う方法です。

「Arduino シリアル変換器」などでググるとArduino Unoの記事ばかり出てきます。
Arduino Unoではボード上のTXピン・RXピンから直接信号を取れば単体のシリアル変換器として使えます。
しかしCH380GのArduino Nanoではそのままでは動きません。

## やり方

CH340Gから直接信号をとってくる必要があります。

{{< figure src="/images/nano.jpg" >}}

TX・RXはどっちから見た送受信なのかによって変わるので動かない場合は入れ替えてみるといいかもしれない。

## 参考
[https://forum.arduino.cc/index.php?topic=458961.0](https://forum.arduino.cc/index.php?topic=458961.0)



