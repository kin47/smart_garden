import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_token_request.freezed.dart';
part 'device_token_request.g.dart';

@freezed
class DeviceTokenRequest with _$DeviceTokenRequest {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DeviceTokenRequest({
    required String deviceToken,
  }) = _DeviceTokenRequest;

  factory DeviceTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceTokenRequestFromJson(json);
}