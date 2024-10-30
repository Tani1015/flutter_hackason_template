import 'package:cloud_functions/cloud_functions.dart';

class FirebaseFunctionsHelper {
  FirebaseFunctionsHelper._();

  static FirebaseFunctionsHelper get instance => _instance;
  static final _instance = FirebaseFunctionsHelper._();

  static final _functions =
      FirebaseFunctions.instanceFor(region: 'asia-northeast1');

  Future<HttpsCallableResult<Map<String, dynamic>>> httpsCallable(
    String name,
    Map<String, dynamic> options,
  ) async =>
      _functions.httpsCallable(name)(options);

  Future<HttpsCallableResult<void>> httpsCallableOnVoid(
    String name,
    Map<String, dynamic> options,
  ) async =>
      _functions.httpsCallable(name)(options);
}
