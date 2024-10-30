import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHelper {
  FirebaseMessagingHelper._();

  static FirebaseMessagingHelper get instance => _instance;
  static final _instance = FirebaseMessagingHelper._();

  static final _messaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async => _messaging.requestPermission();

  Future<void> setForegroundNotificationPresentationOptions() async =>
      _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        sound: true,
      );

  Future<void> onMessageOnListen(RemoteMessage message) async {
    if (message.notification != null) {}
  }

  Future<void> subscribeToTopic(String topic) async =>
      _messaging.subscribeToTopic(topic);

  Future<void> unsubscribeFromTopic(String topic) async =>
      _messaging.unsubscribeFromTopic(topic);

  Future<RemoteMessage?> getInitialMessage() async =>
      _messaging.getInitialMessage();

  Future<String?> getToken() async => _messaging.getToken();
  Future<void> deleteToken() async => _messaging.deleteToken();

  StreamSubscription<String> onTokenRefreshListen(
    void Function(String)? onData,
  ) =>
      _messaging.onTokenRefresh.listen(onData);
}
