import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_to_kit_request.freezed.dart';
part 'connect_to_kit_request.g.dart';

@freezed
class ConnectToKitRequest with _$ConnectToKitRequest {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory ConnectToKitRequest({
    required int kitId,
    required String password,
  }) = _ConnectToKitRequest;

  factory ConnectToKitRequest.fromJson(Map<String, dynamic> json) =>
      _$ConnectToKitRequestFromJson(json);
}
