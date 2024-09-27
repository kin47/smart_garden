part of 'change_user_information_bloc.dart';

@freezed
class ChangeUserInformationEvent with _$ChangeUserInformationEvent {
  const factory ChangeUserInformationEvent.init({
    required UserEntity user,
  }) = _Init;

  const factory ChangeUserInformationEvent.onChangeAvatar({
    required XFile avatar,
  }) = _ChangeAvatar;

  const factory ChangeUserInformationEvent.onChangeCoverImage({
    required XFile coverImage,
  }) = _ChangeCoverImage;

  const factory ChangeUserInformationEvent.onInputName({
    required String name,
  }) = _InputName;

  const factory ChangeUserInformationEvent.onInputCurrentPassword({
    required String password,
  }) = _InputCurrentPassword;

  const factory ChangeUserInformationEvent.onInputNewPassword({
    required String password,
  }) = _InputNewPassword;

  const factory ChangeUserInformationEvent.onPasswordVisibilityChanged({
    required bool isVisible,
  }) = _ShowPasswordVisibility;

  const factory ChangeUserInformationEvent.updateUserInfo() = _UpdateUserInfo;
}
