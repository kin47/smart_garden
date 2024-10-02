part of 'home_bloc.dart';

@CopyWith()
class HomeState extends BaseBlocState {
  final KitEntity? kit;

  const HomeState({
    required super.status,
    super.message,
    this.kit,
  });

  factory HomeState.init() {
    return const HomeState(
      status: BaseStateStatus.init,
    );
  }

  @override
  List get props => [
    status,
    message,
    kit,
  ];
}
