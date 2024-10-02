import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/kit_entity.dart';
import 'package:smart_garden/features/domain/entity/news_entity.dart';
import 'package:smart_garden/features/domain/repository/kit_repository.dart';
import 'package:smart_garden/features/domain/repository/news_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

part 'home_bloc.freezed.dart';

part 'home_bloc.g.dart';

@injectable
class HomeBloc extends BaseBloc<HomeEvent, HomeState>
    with BaseCommonMethodMixin {
  HomeBloc(this._newsRepository, this._kitRepository)
      : super(HomeState.init()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
        init: () => init(emit),
      );
    });
  }

  final NewsRepository _newsRepository;
  final KitRepository _kitRepository;

  PagingController<int, NewsEntity> pagingController =
      PagingController(firstPageKey: 1);

  Future init(Emitter<HomeState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final int kitId =
        await getIt<LocalStorage>().get(KitConstants.kitId) ?? -1;
    final res = await _kitRepository.getKitDetail(kitId: kitId);
    res.fold(
      (l) => emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: l.getError,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
          kit: r,
        ),
      ),
    );
  }

  Future getNews(Emitter<HomeState> emit) async {
    final res = await _newsRepository.getNews(
      request: PaginationRequest(
        page: 1,
        limit: 4,
      ),
    );
    pagingControllerOnLoad(
      1,
      pagingController,
      res,
      onError: (e) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failed,
            message: e,
          ),
        );
      },
      onSuccess: (data) {
        emit(
          state.copyWith(
            status: BaseStateStatus.idle,
          ),
        );
      },
    );
  }
}
