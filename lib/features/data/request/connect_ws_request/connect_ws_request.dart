import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_ws_request.freezed.dart';
part 'connect_ws_request.g.dart';

@freezed
class ConnectWSRequest with _$ConnectWSRequest {
  const factory ConnectWSRequest({
    required int userId,
  }) = _ConnectWSRequest;

  factory ConnectWSRequest.fromJson(Map<String, dynamic> json) =>
      _$ConnectWSRequestFromJson(json);
}
