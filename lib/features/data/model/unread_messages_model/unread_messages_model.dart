class UnreadMessagesModel {
  const UnreadMessagesModel({required this.hasUnreadMessages});

  final bool hasUnreadMessages;

  factory UnreadMessagesModel.fromJson(Map<String, dynamic> json) {
    return UnreadMessagesModel(
      hasUnreadMessages: json['has_unread_messages'] as bool? ?? false,
    );
  }
}
