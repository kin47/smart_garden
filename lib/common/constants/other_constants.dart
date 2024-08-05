import 'package:flutter/material.dart';

class LocalizationConstants {
  static const Locale viLocale = Locale('vi', 'VN');
  static const Locale enUSLocale = Locale('en', 'US');
  static const path = 'assets/translations';
}

class NotificationConfig {
  static const highImportance = "High Importance channel";
  static const highChannelId = "flutter_channel_id_0";
  static const highChannelDescription = "Floating notification with sound";
  static const notificationIconPath = 'ic_notification';
}

class Config {
  static const memCacheHeight = 150;
  static const memCacheWidth = 150;
  static const defaultDurationShowToast = 2; //seconds
}

class AnimationConstants {
  static const crossFadeDuration = Duration(milliseconds: 200);
}

class QuizConstants {
  static const double defaultTime = 30; // seconds
}

class RegexConstants {
  // allow these character . ? _  ! @ # % & / and a-z, A-Z, 0-9
  static final password = RegExp(r'''^[a-zA-Z0-9.?_!@#%&/]+''');
  // Decimal with 1 digit or 2-digit integer
  static final eosPercent = RegExp(r'^(0|[1-9]\d?)([.,]\d?)?$');
  // 4-digit integer
  static final eosMicroLiter = RegExp(r'^(?!0\d)\d{0,4}$');
  // 3-digit decimal or 1-digit integer
  static final fev1 = RegExp(r'^\d?([.,]\d{0,3})?$');
}
