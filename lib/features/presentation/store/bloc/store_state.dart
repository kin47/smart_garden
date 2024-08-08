part of 'store_bloc.dart';

@CopyWith()
class StoreState extends BaseBlocState {
  const StoreState({
    required super.status,
    super.message,
  });

  factory StoreState.init() {
    return const StoreState(
      status: BaseStateStatus.init,
    );
  }

  @override
  List get props => [
    status,
    message,
  ];
}
