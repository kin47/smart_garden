part of 'profile_bloc.dart';

@CopyWith()
class ProfileState extends BaseBlocState {
  final UserEntity? user;

  const ProfileState({
    required super.status,
    super.message,
    this.user,
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
  ];
}
