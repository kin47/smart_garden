import 'package:smart_garden/features/data/model/chat_message_model/chat_message_model.dart';
import 'package:smart_garden/features/domain/enum/sender_enum.dart';

class ChatMessageEntity {
  int? id;
  String message;
  DateTime time;
  SenderEnum sender;
  bool isAdminRead;

  ChatMessageEntity({
    this.id,
    required this.message,
    required this.time,
    required this.sender,
    required this.isAdminRead,
  });

  factory ChatMessageEntity.fromModel(ChatMessageModel model) {
    return ChatMessageEntity(
      id: model.id ?? 0,
      message: model.message ?? '',
      time: model.time ?? DateTime.now(),
      sender: model.sender ?? SenderEnum.user,
      isAdminRead: model.isAdminRead ?? false,
    );
  }

  ChatMessageEntity copyWith({
    int? id,
    String? message,
    DateTime? time,
    SenderEnum? sender,
    bool? isAdminRead,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      message: message ?? this.message,
      time: time ?? this.time,
      sender: sender ?? this.sender,
      isAdminRead: isAdminRead ?? this.isAdminRead,
    );
  }
}
