class FirebaseAuthErrorCodes {
  /// FirebaseAuthExceptionエラーコード
  /// メールアドレスは既に存在する
  static const emailAlreadyInUse = 'email-already-in-use';

  /// メールアドレスが正しくない
  static const invalidEmail = 'invalid-email';

  /// メールアドレス/パスワードのアカウントが有効でない
  /// FirebaseコンソールのAuthタブでメールアドレス認証を有効にする必要がある
  static const operationNotAllowed = 'operation-not-allowed';

  /// パスワードが十分に強力でない
  static const weakPassword = 'weak-password';

  /// メールアドレス認証情報が提供されていない
  /// 事前にメールアドレスでサインインする必要がある
  static const missingEmail = 'missing-email';

  /// メールアドレスが有効でない
  static const authInvalidEmail = 'auth/invalid-email';

  /// Androidアプリのインストールが必要
  static const authMissingAndroidPkgName = 'auth/missing-android-pkg-name';

  /// リクエストに続行URLの指定が必要
  static const authMissingContinueUri = 'auth/missing-continue-uri';

  /// App Store IDが提供されている場合、iOSバンドルIDが必要
  static const authMissingIosBundleId = 'auth/missing-ios-bundle-id';

  /// リクエストで提供された続行URLが無効
  static const authInvalidContinueUri = 'auth/invalid-continue-uri';

  /// 続行URLのドメインがホワイトリストに登録されていない
  /// Firebaseコンソールでドメインをホワイトリストに登録する必要がある
  static const authUnauthorizedContinueUri = 'auth/unauthorized-continue-uri';

  /// メールアドレスに対応するユーザーが存在しない
  static const authUserNotFound = 'user-not-found';

  /// メールアドレスのパスワードが間違っている
  /// または、メールアドレスに対応するユーザーがパスワードを設定していない
  static const wrongPassword = 'wrong-password';

  /// メールアドレスに対応するユーザーが無効
  static const userDisabled = 'user-disabled';

  /// メールアドレスに対応するユーザーが存在しない
  static const userNotFound = 'user-not-found';
}
