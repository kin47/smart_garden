import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class LogUtils {
  /// methodCount:2 , // number of method calls to be displayed
  /// errorMethodCount: 8, // number of method calls if stacktrace is provided
  /// lineLength: 120, // width of the output
  /// colors: true, // Colorful log messages
  /// printEmojis: true, // Print an emoji for each log message
  /// printTime: false, // Should each log print contain a timestamp
  final bool showLog = kDebugMode;
  // final bool showLog = kDebugMode && kReleaseMode; //For test notification

  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  void debugNormal(String text) {
    if (showLog) {
      // ignore: avoid_print
      print("==========================================================");
      // ignore: avoid_print
      print("Logs Debug: $text");
      // ignore: avoid_print
      print("==========================================================");
    }
  }

  void logD(String text) {
    if (showLog) _logger.d(text);
  }

  void logI(String text) {
    if (showLog) _logger.i(text);
  }

  void logW(String text) {
    if (showLog) _logger.w(text);
  }

  void logE(String text) {
    if (showLog) _logger.e(text);
  }
}
