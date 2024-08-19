import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/store_entity.dart';
import 'package:smart_garden/features/domain/repository/store_repository.dart';

part 'store_event.dart';

part 'store_state.dart';

part 'store_bloc.freezed.dart';

part 'store_bloc.g.dart';

@injectable
class StoreBloc extends BaseBloc<StoreEvent, StoreState>
    with BaseCommonMethodMixin {
  StoreBloc(this._storeRepository) : super(StoreState.init()) {
    on<StoreEvent>((event, emit) async {
      await event.when(
        getData: (page) => _getData(emit, page),
        onChooseStore: (store) => _onChooseStore(emit, store),
      );
    });
  }

  final StoreRepository _storeRepository;

  PagingController<int, StoreEntity> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _getData(Emitter<StoreState> emit, int page) async {
    if (page == 1) {
      emit(state.copyWith(status: BaseStateStatus.loading));
    }
    final res = await _storeRepository.getStores(
      request: PaginationRequest(
        page: page,
        limit: ApiConfig.limit,
      ),
    );
    pagingControllerOnLoad<StoreEntity>(
      page,
      pagingController,
      res,
      onError: (String message) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failed,
            message: message,
          ),
        );
      },
      onSuccess: (r) {
        emit(
          state.copyWith(
            status: BaseStateStatus.idle,
            storeList: pagingController.itemList!,
          ),
        );
      },
    );
  }

  Future<void> _onChooseStore(
      Emitter<StoreState> emit, StoreEntity store) async {
    if (state.selectedStore != store) {
      emit(
        state.copyWith(
          selectedStore: store,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
