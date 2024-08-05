part of 'home_user_bloc.dart';

@freezed
class HomeUserEvent with _$HomeUserEvent {
  const factory HomeUserEvent.init({
    required UserEntity userEntity,
  }) = _Init;

  const factory HomeUserEvent.sendLocation({
    required bool isPressSend,
    required DateTime time,
  }) = _SendLocation;

  const factory HomeUserEvent.sendSms() = _SendSMS;

  const factory HomeUserEvent.signOut() = _SignOut;
}
