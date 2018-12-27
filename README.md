# murufon's blog

むるふぉんのブログ by hugo
https://murufon.github.io/

# command

## 新規記事作成
新しくpostを作成して、Atomで開く

直接記事名を指定する
```bash
$ ./new.sh my-new-post
```
対話的に記事名を指定する
```bash
$ ./new.sh
Please input article name:
```

## デプロイ
ビルド→コミット→プッシュ
```bash
$ ./deploy.sh
```