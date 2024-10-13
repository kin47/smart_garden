import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:smart_garden/base/network/dio/dio_builder.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/web_socket/chat_socket.dart';

@module
abstract class AppModule {
  @singleton
  Dio get dio => DioBuilder().getDio();

  @Named('weatherDio')
  @singleton
  Dio get weatherDio => WeatherDioBuilder().getDio();

  @singleton
  EventBus get eventBus => EventBus();

  @singleton
  ChatSocket get chatSocket => ChatSocket();

  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  @singleton
  Logger get loggerHelper => Logger(
    printer: PrettyPrinter(),
  );
}
