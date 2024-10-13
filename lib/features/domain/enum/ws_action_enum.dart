import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum WSActionEnum {
  authenticate('authenticate'),
  sendChatMessage('send-chat-message'),
  seen('seen');

  const WSActionEnum(this.value);
  final String value;
}