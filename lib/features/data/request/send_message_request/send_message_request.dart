import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_garden/features/domain/enum/sender_enum.dart';

part 'send_message_request.freezed.dart';
part 'send_message_request.g.dart';

@freezed
class SendMessageRequest with _$SendMessageRequest {
  const factory SendMessageRequest({
    required SenderEnum sender,
    required String message,
    required DateTime time,
  }) = _SendMessageRequest;

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);
}