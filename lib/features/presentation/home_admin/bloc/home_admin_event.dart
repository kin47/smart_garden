part of 'home_admin_bloc.dart';

@freezed
class HomeAdminEvent with _$HomeAdminEvent {
  const factory HomeAdminEvent.init({
    required UserEntity userEntity,
  }) = _Init;

  const factory HomeAdminEvent.getMyLocation({
    required LatLng myLocation,
  }) = _GetMyLocation;

  const factory HomeAdminEvent.updateBlindPersonLocation({
    required LatLng blindPersonLocation,
  }) = _UpdateBlindPersonLocation;

  const factory HomeAdminEvent.getBlindPersonLocation() =
      _GetBlindPersonLocation;

  const factory HomeAdminEvent.signOut() = _SignOut;
}
