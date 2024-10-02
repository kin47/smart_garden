part of 'chat_bloc.dart';

@CopyWith()
class ChatState extends BaseBlocState {
  const ChatState({
    required super.status,
    super.message,
  });

  factory ChatState.init() => const ChatState(
      status: BaseStateStatus.init,
    );

  @override
  List get props => [
    status,
    message,
  ];
}
