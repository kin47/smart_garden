import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';

abstract class SmsRepository {
  Future<Either<BaseError, bool>> sendSMSMessage({
    required String message,
    required String phoneNumber,
  });
}
