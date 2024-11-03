# Flutter_Hackathon_Template

## 環境

### Flutter / Dart

Flutter は stable チャネルの最新バージョン、Dart はそれに付属したバージョンを用いる。
fvm で Flutter のバージョンを管理すること(fvm のバージョンは 3.0系)

- Flutter 3.24.4
- Dart 3.5.4

## melos について
apps, packages 全体で使用できるテストコマンド、CI/CD コマンドなどは実装ごとに追加していくこと

## 開発ガイドライン

→ [ガイドライン](_document/guidelines.md)

## init

fvm の sdk パスが指定できない場合
fvm のコマンドから melos コマンドを行う
```
melos bs → fvm flutter pub run melos bs
melos gen → fvm flutter pub run melos gen
```

### melos コマンドのアクティブ
```
(fvm) flutter pub global activate melos
```

### セットアップ
```
melos bs
もしくは
melos bootstrap
```

### パッケージ取得
```
melos get
```

### Auto Generated

```
melos gen
melos gen:watch
```

### App Distribution
 
環境を分ける場合はコマンドごとに `dart-define-from-file` を追加する

- App Bundle
```
melos build:apb
```

- APK
```
melos build:apk
```

- IPA
```
melos build:ipa
```

- WEB
```
melos build:web
```

### そのほかコマンド

- デプロイ
`flutterfire`、`firebase-cli`などで `firebase` のデプロイ環境の構築が終わっている場合
```
melos deploy
```

- パッケージ削除
```
melos clean
```


## Firebase

#### プロジェクトを確認/設定する方法

```shell
プロジェクトを一覧表示
$ firebase projects:list

プロジェクトのエイリアスを確認
$ firebase use

使用するプロジェクトを設定
$ firebase use プロジェクト名またはエイリアス
```

### デプロイをする場合

```shell
melos deploy
```

