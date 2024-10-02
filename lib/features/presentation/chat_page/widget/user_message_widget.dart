import 'package:flutter/material.dart';

import '../../../domain/entity/chat_message_entity.dart';

class UserMessageWidget extends StatefulWidget {
  final ChatMessageEntity message;
  final String? firstMessageInDay;

  const UserMessageWidget({
    super.key,
    required this.message,
    this.firstMessageInDay,
  });

  @override
  State<UserMessageWidget> createState() => _UserMessageWidgetState();
}

class _UserMessageWidgetState extends State<UserMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [],
        )
      ],
    );
  }
}
