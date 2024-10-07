part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.init() = _Init;

  const factory ChatEvent.getChatMessages(int page) = _GetChatMessages;
}
