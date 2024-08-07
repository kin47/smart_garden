part of 'core_bloc.dart';

@CopyWith()
class CoreState extends BaseBlocState {
  final CoreTab activeTab;

  const CoreState({
    required super.status,
    super.message,
    required this.activeTab,
  });

  factory CoreState.init() => const CoreState(
        status: BaseStateStatus.init,
        activeTab: CoreTab.home,
      );

  @override
  List get props => [
    status,
    message,
    activeTab,
  ];
}
