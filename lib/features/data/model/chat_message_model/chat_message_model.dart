import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_garden/features/domain/enum/sender_enum.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
abstract class ChatMessageModel with _$ChatMessageModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ChatMessageModel({
    int? id,
    String? message,
    DateTime? time,
    SenderEnum? sender,
    bool? isAdminRead,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
        id: (json['id'] as num?)?.toInt(),
        message: json['body'] as String?,
        time: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        sender: (json['sender_id'] as num?)?.toInt() == 1
            ? SenderEnum.admin
            : SenderEnum.user,
        isAdminRead: false,
      );
}
