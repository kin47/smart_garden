import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/data/datasource/remote/sms_service/sms_service.dart';
import 'package:smart_garden/features/domain/repository/sms_repository.dart';

@Injectable(as: SmsRepository)
class SmsRepositoryImpl implements SmsRepository {
  final SmsService _service;

  SmsRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, bool>> sendSMSMessage({
    required String message,
    required String phoneNumber,
  }) async {
    try {
      final FormData formData = FormData();
      formData.fields.addAll([
        MapEntry("phone_number", phoneNumber),
        MapEntry("message", message),
      ]);
      final res = await _service.sendSmsMessage(
        request: formData,
      );
      return right(true);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }
}
