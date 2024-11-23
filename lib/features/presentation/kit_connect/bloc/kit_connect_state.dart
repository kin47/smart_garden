part of 'kit_connect_bloc.dart';

@CopyWith()
class KitConnectState extends BaseBlocState {
  final int id;
  final KitEntity? kit;
  final bool isErrorFromGetKitDetail;
  final bool isPasswordVisible;

  const KitConnectState({
    required super.status,
    super.message,
    required this.id,
    this.kit,
    this.isErrorFromGetKitDetail = false,
    this.isPasswordVisible = false,
  });

  factory KitConnectState.initial() => const KitConnectState(
        status: BaseStateStatus.init,
        id: -1,
      );

  @override
  List get props => [
        status,
        message,
        id,
        kit,
        isErrorFromGetKitDetail,
        isPasswordVisible,
      ];
}
