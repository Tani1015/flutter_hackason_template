# Flutter_Hackathon_Template

## init

### melos コマンドのアクティブ
```
(fvm) dart pub global activate melos
```

### パッケージ取得
```
melos bs
もしくは
melos bootstrap
```

### Auto Generated

```
melos gen
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

### そのほかコマンド

```
melos clean
```
