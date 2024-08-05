part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.onInputUsername({
    required String username,
  }) = LoginInputUsername;

  const factory LoginEvent.onInputPassword({
    required String password,
  }) = LoginInputPassword;

  const factory LoginEvent.onPasswordVisibilityChanged({
    required bool isVisible,
  }) = LoginShowPasswordChanged;

  const factory LoginEvent.login() = Login;
}
