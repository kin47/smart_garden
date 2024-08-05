import 'dart:convert';
import 'dart:io';

import 'package:smart_garden/common/logger/index.dart';
import 'package:smart_garden/common/notification/local_notification_helper.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class PushNotificationHelper {
  late final FirebaseMessaging _firebaseMessaging;
  Function(String)? handleNotificationOnTap;
  String? pushToken;
  String? _payLoad;

  Future<void> initialize({
    Function(String)? handleNotificationOnTap,
  }) async {
    await Firebase.initializeApp();
    _firebaseMessaging = FirebaseMessaging.instance;
    this.handleNotificationOnTap = handleNotificationOnTap;
    await _fcmInitialization();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future _fcmInitialization() async {
    try {
      await getPushToken();
      FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        pushToken = token;
      });

      final RemoteMessage? initMessage =
          await _firebaseMessaging.getInitialMessage();
      if (initMessage != null) {
        _payLoad = jsonEncode(initMessage);
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _payLoad = getNotificationContent(message);
        if (message.notification != null) {
          getIt<LogUtils>().logD("Message: ${message.notification?.title}");
          if (Platform.isAndroid) {
            getIt<LocalNotificationHelper>().showNotification(
              title: message.notification?.title ?? '',
              body: message.notification?.body ?? '',
            );
          }
        }
      });
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _payLoad = getNotificationContent(message);
        handleNotificationOnTap!(_payLoad!);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<String?> getPushToken() async {
    pushToken ??= await _firebaseMessaging.getToken();
    getIt<LogUtils>().logD('fcm token: $pushToken');
    return pushToken;
  }

  Future<void> unSubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> deleteToken() async {
    pushToken = null;
    await _firebaseMessaging.deleteToken();
  }

  void removeBadgeCount() {
    if (Platform.isIOS) {
      ///todo: handle for ios
    } else if (Platform.isAndroid) {
      ///todo: handle for android
    }
  }
}

String getNotificationContent(RemoteMessage? message) {
  if (message == null) return 'RemoteMessage is Null';
  final body = {
    'notification': {
      'title': message.notification?.title,
      'body': message.notification?.body,
    },
    'data': message.data,
    "collapse_key": message.collapseKey,
    "message_id": message.messageId,
    "sent_time": message.sentTime?.millisecondsSinceEpoch,
    "from": message.from,
    "ttl": message.ttl,
  };
  return jsonEncode(body);
}

Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage remoteMessage,
) async {
  // injector<LogUtils>()
  //     .logD('Handling a background message ${remoteMessage.messageId}');
  // injector<LogUtils>()
  //     .logD('message data ${getNotificationContent(remoteMessage)}');
}
