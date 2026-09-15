import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_token_delete_request.freezed.dart';
part 'device_token_delete_request.g.dart';

@freezed
abstract class DeviceTokenDeleteRequest with _$DeviceTokenDeleteRequest {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DeviceTokenDeleteRequest({required String deviceId}) =
      _DeviceTokenDeleteRequest;

  factory DeviceTokenDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceTokenDeleteRequestFromJson(json);
}
