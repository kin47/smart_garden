part of 'home_admin_bloc.dart';

@CopyWith()
class HomeAdminState extends BaseBlocState {
  final UserEntity? userEntity;
  final LatLng myLocation;
  final LatLng blindPersonLocation;

  const HomeAdminState({
    required super.status,
    super.message,
    this.userEntity,
    required this.myLocation,
    required this.blindPersonLocation,
  });

  factory HomeAdminState.init() {
    return const HomeAdminState(
      status: BaseStateStatus.init,
      myLocation: LocationConstants.defaultLocation,
      blindPersonLocation: LocationConstants.blindPersonLocation,
    );
  }

  @override
  List get props => [
    status,
    message,
    userEntity,
    myLocation,
    blindPersonLocation,
  ];
}
