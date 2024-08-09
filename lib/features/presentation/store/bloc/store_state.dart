part of 'store_bloc.dart';

@CopyWith()
class StoreState extends BaseBlocState {
  final StoreEntity? selectedStore;
  final List<StoreEntity> storeList;

  const StoreState({
    required super.status,
    super.message,
    this.selectedStore,
    this.storeList = const [],
  });

  factory StoreState.init() {
    return const StoreState(
      status: BaseStateStatus.init,
      storeList: [],
    );
  }

  @override
  List get props => [
    status,
    message,
    selectedStore,
    storeList,
  ];
}
