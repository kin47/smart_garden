part of 'profile_bloc.dart';

@CopyWith()
class ProfileState extends BaseBlocState {
  final UserEntity? user;
  final bool hasUnreadMessages;

  const ProfileState({
    required super.status,
    super.message,
    this.user,
    this.hasUnreadMessages = false,
  });

  factory ProfileState.init() {
    return const ProfileState(
      status: BaseStateStatus.init,
    );
  }

  @override
  List get props => [
    status,
    message,
    user,
    hasUnreadMessages,
  ];
}
