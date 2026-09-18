class ConversationModel {
  const ConversationModel({required this.id});

  final int id;

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(id: (json['id'] as num).toInt());
  }
}
