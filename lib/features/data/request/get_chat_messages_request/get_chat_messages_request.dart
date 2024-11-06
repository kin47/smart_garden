import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_garden/common/config/api_config.dart';
part 'get_chat_messages_request.freezed.dart';
part 'get_chat_messages_request.g.dart';

@freezed
class GetChatMessagesRequest with _$GetChatMessagesRequest {
  @JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
  factory GetChatMessagesRequest({
    int? lastId,
    @Default(ApiConfig.limit) int limit,
  }) = _GetChatMessagesRequest;

  factory GetChatMessagesRequest.fromJson(Map<String, dynamic> json) =>
      _$GetChatMessagesRequestFromJson(json);
}