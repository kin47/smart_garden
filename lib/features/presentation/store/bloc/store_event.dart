part of 'store_bloc.dart';

@freezed
class StoreEvent with _$StoreEvent {
  const factory StoreEvent.getData({
    required int pageKey,
  }) = _GetData;

  const factory StoreEvent.onChooseStore({
    required StoreEntity store,
  }) = _OnChooseStore;
}
