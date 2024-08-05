part of 'splash_bloc.dart';

@CopyWith()
class SplashState extends BaseBlocState {
  final SplashActionState actionState;
  final UserEntity? user;

  const SplashState({
    required super.status,
    super.message,
    required this.actionState,
    this.user,
  });

  factory SplashState.init() => const SplashState(
        actionState: SplashActionState.init,
        status: BaseStateStatus.init,
      );

  @override
  List get props => [
        status,
        message,
        actionState,
        user,
      ];
}

enum SplashActionState {
  init,
  goToLogin,
  goToUserHome,
  goToAdminHome,
}
