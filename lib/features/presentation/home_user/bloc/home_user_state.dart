part of 'home_user_bloc.dart';

@CopyWith()
class HomeUserState extends BaseBlocState {
  final UserEntity? userEntity;

  const HomeUserState({
    required super.status,
    super.message,
    this.userEntity,
  });

  factory HomeUserState.init() {
    return const HomeUserState(
      status: BaseStateStatus.init,
    );
  }

  @override
  List get props => [
    status,
    message,
    userEntity,
  ];
}