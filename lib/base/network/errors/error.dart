import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';

@freezed
class BaseError with _$BaseError {
  const factory BaseError.httpInternalServerError(String errorBody) =
      HttpInternalServerError;

  const factory BaseError.dataError(String message) = DataError;

  const factory BaseError.httpUnAuthorizedError() = HttpUnAuthorizedError;

  const factory BaseError.httpUnknownError(String message) = HttpUnknownError;
}
