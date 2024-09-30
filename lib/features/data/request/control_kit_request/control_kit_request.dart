import 'package:freezed_annotation/freezed_annotation.dart';

part 'control_kit_request.freezed.dart';
part 'control_kit_request.g.dart';

@freezed
class ControlKitRequest with _$ControlKitRequest {
  @JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
  const factory ControlKitRequest({
    bool? turnOnLight,
    bool? turnOnPump,
    bool? isAutoLight,
    bool? isAutoPump,
    int? lightThreshold,
    int? pumpThreshold,
  }) = _ControlKitRequest;

  factory ControlKitRequest.fromJson(Map<String, dynamic> json) =>
      _$ControlKitRequestFromJson(json);
}