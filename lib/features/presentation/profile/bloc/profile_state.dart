part of 'profile_bloc.dart';

@CopyWith()
class ProfileState extends BaseBlocState {
  const ProfileState({
    required super.status,
    super.message,
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
  ];
}
