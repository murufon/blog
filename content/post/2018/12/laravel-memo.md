---
title: "Laravelのメモ書き"
date: 2018-12-31T11:01:21+09:00
draft: false
tags: ["Laravel","PHP"]
categories: ["Laravel"]
---

## 環境

- Mac OS Mojave 10.14.2
- PHP 7.1.19

## 必要なもののインストール
```bash
composer global require laravel/installer
```
## Laravelプロジェクトの作成
```bash
cd <INSTALL_DIR>
laravel new <PROJECT_NAME>
cd <PROJECT_NAME>
composer install
```

## Laravelの要素

### ルーティング
場所
`routes/web.php`

### ビュー
場所
`resources/views/<VIEW_NAME>.blade.php`

### コントローラ
つくる
`php artisan make:controller <VIEW_NAME>Controller`
場所
`app/Http/Controllers/<VIEW_NAME>Controller.php`

## Laravel Form Builderを使った時のリクエストの取り出し方
ネット上には引数として直接`$request`を受け取っているサンプルが多かったが、$formBuilderからリクエストを取り出してやることでそれらのサンプルコードと同様の処理ができる
```php
function create(FormBuilder $formBuilder) {
    // フォームの形式にする
    $form = $formBuilder->create(\App\Forms\SomeForm::class);
    // リクエストを取り出す
    $request = $form->getRequest();
(中略)
```

## 参考リンク集
データベース：マイグレーション 5.5 Laravel
https://readouble.com/laravel/5.5/ja/migrations.html

kristijanhusak/laravel-form-builder リポジトリ
https://github.com/kristijanhusak/laravel-form-builder
Laravel form builderのドキュメント
https://kristijanhusak.github.io/laravel-form-builder/

(Laravel) fillを使ってモデルの複数カラムを更新する - Qiita
https://qiita.com/tkt989/items/c2e01ec2fe91ef5f08d2

Laravel5.6 ログインユーザー情報取得と表示 - Qiita
https://qiita.com/kim_kou/items/b95af87568cdbf06fa61

Laravel5.6 入力画面から完了画面までの流れ
https://9cubed.info/article/laravel5/laravel_5_app/
入力画面→確認画面→完了画面のセッションの扱いとか

