# 開発のガイドライン

## パッケージ

### pubspec.yaml

### サードパーティのパッケージ

- コントロールしにくい依存を増やすことになるので追加前によく検討する
    - テストコードが書かれていないパッケージはデグレのリスクが高い
- 使用する際は `melos.yaml`で書かれているパッケージは最新にしておく

## アーキテクチャとディレクトリ構造
<!-- TODO: packages 内のcore ディレクトリのスコープを定める -->
- packages 内のアーキテクチャを定める

UI とそれ以外に分けたシンプルな構造。 
UI は画面単位、UI 以外はドメイン単位（どちらも一部の共通機能などはその機能単位）。
- games
    - ゲーム
        - 

- domain
    - モデル
    - ユースケース
    - サービス、リポジトリ
        - DB などの必要な処理をまず用意してから使う側を書いていくと良い
        - Notifier から利用し、View では直接利用しない
- presentation
    - UI（View や Notifier）
        - ビジネスロジックを持たない
            - Notifier に持たせるのは View のためのロジックのみ
            - View や Notifier からドメインロジックのメソッドを呼ぶ（基本的には Notifier から）
        - Notifier は Widget を持たない

 インフラ層はパッケージ側で定義するため作成しない
 ゲームを使用する際は lib 直下に `games` フォルダを作成し、ゲームに関する画面、モデルなどはその配下に配置する
 `games` 内のデータモデルなどを他画面で使用することがある場合は、`lib`直下にディレクトリを作成しそこに配置する
 アプリ側とゲーム側でディレクトリを分けてください

## コード

### 変数・定数など

- 同一ライブラリ内でのみ使用するプロパティ、メソッド等はプライベートにする
- グローバルな定数には `k` の接頭辞を付ける
    - ローカルの定数に `_k` を付けても良い
- 数値型はそれぞれの型に沿ったリテラル表記を使う
    - double 型の引数に int の形式で渡すこともできるが、int なら int、double なら double の表記を常に使う

### プレゼンテーション層

- Widget
    - 基本的にはメソッドにせずに独立した StatelessWidget/StatefulWidget にする
    - 可能な限り const コンストラクタにする
    - XxxxWidget のように名前に Widget を付けない（冗長）
- Builder
    - Builder を使うよりも Widget を分割することを検討する
- ステート
    - StateNotifier のファイルから分離して個別のファイルにする
- of()
    - `Navigator.of(context).push(...)` と `Navigator.push(context, ...)` のように二通りの
    書き方ができるものがあるが、より Flutter らしい書き方である `of()` を一貫して用いること

### Route

- `Route` を返す `route()` というメソッドを各ページに用意する
- `RouteSettings` で画面名を設定する
    - 各画面のクラスに static const で `routeName` という名称で画面名を持たせる
        - そうすると複数ページを一気に閉じたいときに
        `Navigator.of(context).popUntil(ModalRoute.withName(XxxPage.routeName))` のように書ける

### import と export

- 相対パスを用いない
- 複数の export をまとめた barrel ファイルが存在する場合はそれを使うこと
    - ただし barrel ファイルに含まれるファイル間で import を行う場合は対象ファイル指定で import すること
    - 使用しない import はツリーシェイクされるのでアプリサイズ等に影響しない
- dependencies のほうは空行で区切ったブロックごとにパスのテキスト順にする（単に把握しやすくするため）
    - Dart/Flutter 公式系パッケージ
        - 一般に Dart と Flutter のパッケージを分けることも多いが、このプロジェクトでは分けない
    - 空行
    - サードパーティパッケージ
    - 空行
    - アプリパッケージ
    - 空行
    - export
        - アプリパッケージ以外も export するなら import と同様に空行で区切る

### 静的解析

- 警告を放置しない

### テストコード

- 何らかの変更を行うと不具合に繋がる危険がある部分は特に単体テストを用意する

### コメント

- 日本語で OK
- 必要に応じて `TODO:`、`FIXME:`、`WARNING:`、`HACK:` などを付ける（特に TODO）

### フォーマット

- コミット前に必ず自動整形する
- 80 文字を超える行や短くても括弧が多い行などではカンマによって改行が入るようにする

## バージョン管理

- fvm の 3.0系を使用する
- flutter のバージョンを上げるときは `README.md`を更新すること

### コミットメッセージ

- 日本語で OK
