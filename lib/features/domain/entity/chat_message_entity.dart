import 'package:smart_garden/features/domain/enum/owner_type_enum.dart';

class ChatMessageEntity {
  int id;
  String? message;
  DateTime transDate;
  OwnerTypeEnum ownerType;
  int? user;

  ChatMessageEntity({
    required this.id,
    this.message,
    required this.transDate,
    required this.ownerType,
    this.user,
  });

  // factory ChatMessageEntity.fromModel(ChatMessageModel model) {
  //   return ChatMessageEntity(
  //     id: model.id,
  //     message: model.message,
  //     transDate: model.transDate,
  //     ownerType: model.ownerType,
  //     user: model.user,
  //   );
  // }
  //
  // factory ChatMessageEntity.fromSocket(Messages model) {
  //   return ChatMessageEntity(
  //     id: model.id,
  //     message: model.message,
  //     transDate: model.transDate,
  //     ownerType: model.ownerType,
  //     user: model.userId,
  //   );
  // }
  //
  // ChatMessageEntity copyWith({
  //   int? id,
  //   String? message,
  //   DateTime? transDate,
  //   OwnerTypeEnum? ownerType,
  //   bool? isOpened,
  //   int? user,
  // }) {
  //   return ChatMessageEntity(
  //     id: id ?? this.id,
  //     message: message ?? this.message,
  //     transDate: transDate ?? this.transDate,
  //     ownerType: ownerType ?? this.ownerType,
  //     user: user ?? this.user,
  //   );
  // }
}
