import 'package:flutter/material.dart';
import 'package:smart_garden/features/domain/entity/chat_message_entity.dart';

class AdminMessageWidget extends StatefulWidget {
  final ChatMessageEntity message;
  final String? firstMessageInDay;

  const AdminMessageWidget({
    super.key,
    required this.message,
    this.firstMessageInDay,
  });

  @override
  State<AdminMessageWidget> createState() => _AdminMessageWidgetState();
}

class _AdminMessageWidgetState extends State<AdminMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        )
      ],
    );
  }
}
