# murufon's blog

むるふぉんのブログ by hugo
https://blog.kaio.ga

# command

## 新規記事作成
新しくpostを作成して、Atomで開く

URLは`/post/2018/12/helloworld/`のようになる

### 直接記事名を指定する
```bash
$ ./new.sh my-new-post
```
### 対話的に記事名を指定する
```bash
$ ./new.sh
Please input article name:
```

## デプロイ
github pagesへのデプロイとhugoプロジェクト全体のコミット
```bash
$ ./deploy.sh
```
