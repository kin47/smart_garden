part of 'my_kit_bloc.dart';

@CopyWith()
class MyKitState extends BaseBlocState {
  final MyKitTab currentTab;

  const MyKitState({
    required super.status,
    super.message,
    required this.currentTab,
  });

  factory MyKitState.init() => MyKitState(
    status: BaseStateStatus.init,
    currentTab: MyKitTab.defaultRoute,
  );

  @override
  List get props => [
    status,
    message,
    currentTab,
  ];
}
