part of 'login_bloc.dart';

@CopyWith()
class LoginState extends BaseBlocState {
  final String username;
  final String password;
  final UserEntity? user;
  final bool isPasswordVisible;
  final LoginActionState actionState;

  const LoginState({
    required super.status,
    super.message,
    required this.username,
    required this.password,
    this.isPasswordVisible = false,
    required this.actionState,
    this.user,
  });

  factory LoginState.init() {
    return const LoginState(
      status: BaseStateStatus.init,
      username: '',
      password: '',
      isPasswordVisible: false,
      actionState: LoginActionState.idle,
    );
  }

  bool get validInput => username.isNotEmpty && password.isValidPassword;

  @override
  List get props => [
        status,
        message,
        username,
        password,
        user,
        isPasswordVisible,
        actionState,
      ];
}

enum LoginActionState {
  idle,
  loginError,
  goToAdminHome,
  goToUserHome,
}
