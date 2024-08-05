import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';

class StringConstants {
  static String getPhoneNumberVN(String phoneNumber) {
    return '+84${phoneNumber.substring(1)}';
  }

  static String getSmsMessage(String address, Position position) {
    final String url =
        "https://maps.google.com/?q=${position.latitude},${position.longitude}";
    final String message = "sms_message".tr(
      namedArgs: {
        "address": address,
        "url": url,
      },
    );
    return message;
  }
}
