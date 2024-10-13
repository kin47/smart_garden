import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_garden/features/domain/enum/sender_enum.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
class ChatMessageModel with _$ChatMessageModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ChatMessageModel({
    int? id,
    String? message,
    DateTime? time,
    SenderEnum? sender,
    bool? isAdminRead,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
}
