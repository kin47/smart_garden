part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.onInputEmail({
    required String email,
  }) = RegisterInputEmail;

  const factory RegisterEvent.onInputPassword({
    required String password,
  }) = RegisterInputPassword;

  const factory RegisterEvent.onInputPhoneNumber({
    required String phoneNumber,
  }) = RegisterInputPhoneNumber;

  const factory RegisterEvent.onPasswordVisibilityChanged({
    required bool isVisible,
  }) = RegisterShowPasswordChanged;

  const factory RegisterEvent.register() = Register;
}
