part of 'register_bloc.dart';

@CopyWith()
class RegisterState extends BaseBlocState {
  final String email;
  final String password;
  final String phoneNumber;
  final String name;
  final bool isPasswordVisible;

  const RegisterState({
    required super.status,
    super.message,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.name,
    this.isPasswordVisible = false,
  });

  factory RegisterState.init() {
    return const RegisterState(
      status: BaseStateStatus.init,
      email: '',
      password: '',
      phoneNumber: '',
      name: '',
      isPasswordVisible: false,
    );
  }

  bool get validInput =>
      password.isValidPassword &&
      email.isValidEmail &&
      phoneNumber.length == 10 &&
      name.isNotEmpty;

  @override
  List get props => [
        status,
        message,
        password,
        phoneNumber,
        name,
        email,
        isPasswordVisible,
      ];
}
