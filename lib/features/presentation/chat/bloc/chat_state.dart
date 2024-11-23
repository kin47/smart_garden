part of 'chat_bloc.dart';

@CopyWith()
class ChatState extends BaseBlocState {
  final int? lastSeenMessageIndex;

  const ChatState({
    required super.status,
    super.message,
    this.lastSeenMessageIndex,
  });

  factory ChatState.init() => const ChatState(
      status: BaseStateStatus.init,
    );

  @override
  List get props => [
    status,
    message,
    lastSeenMessageIndex,
  ];
}
