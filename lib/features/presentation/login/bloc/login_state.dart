part of 'login_bloc.dart';

@CopyWith()
class LoginState extends BaseBlocState {
  final String username;
  final String password;
  final UserEntity? user;
  final bool isPasswordVisible;

  const LoginState({
    required super.status,
    super.message,
    required this.username,
    required this.password,
    this.isPasswordVisible = false,
    this.user,
  });

  factory LoginState.init() {
    return const LoginState(
      status: BaseStateStatus.init,
      username: '',
      password: '',
      isPasswordVisible: false,
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
      ];
}