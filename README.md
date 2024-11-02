# Flutter_Hackathon_Template

## init

fvm の sdk パスが指定できない場合
fvm のコマンドから melos コマンドを行う
```
melos bs → fvm flutter pub run melos bs
melos gen → fvm flutter oub run melos gen
```

### melos コマンドのアクティブ
```
(fvm) dart pub global activate melos
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
