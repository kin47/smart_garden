import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_response.freezed.dart';
part 'logout_response.g.dart';

@freezed
class LogoutResponse with _$LogoutResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LogoutResponse({
    String? message,
  }) = _LogoutResponse;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);
}