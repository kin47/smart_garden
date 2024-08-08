part of 'home_bloc.dart';

@CopyWith()
class HomeState extends BaseBlocState {
  const HomeState({
    required super.status,
    super.message,
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
  ];
}
