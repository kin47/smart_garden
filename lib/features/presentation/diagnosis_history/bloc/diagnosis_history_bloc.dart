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
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';
import 'package:smart_garden/features/domain/repository/diagnosis_repository.dart';

part 'diagnosis_history_event.dart';

part 'diagnosis_history_state.dart';

part 'diagnosis_history_bloc.freezed.dart';

part 'diagnosis_history_bloc.g.dart';

@injectable
class DiagnosisHistoryBloc
    extends BaseBloc<DiagnosisHistoryEvent, DiagnosisHistoryState>
    with BaseCommonMethodMixin {
  DiagnosisHistoryBloc(this._diagnosisRepository)
      : super(DiagnosisHistoryState.init()) {
    on<DiagnosisHistoryEvent>((event, emit) async {
      await event.when(
        getData: (page) => _getData(page, emit),
      );
    });
  }

  final DiagnosisRepository _diagnosisRepository;

  PagingController<int, DiagnosisEntity> pagingController =
      PagingController(firstPageKey: 1);

  Future _getData(int page, Emitter<DiagnosisHistoryState> emit) async {
    if (page == 1) {
      emit(
        state.copyWith(
          status: BaseStateStatus.loading,
        ),
      );
    }
    final res = await _diagnosisRepository.getDiagnosisHistory(
      request: PaginationRequest(
        page: page,
      ),
    );
    pagingControllerOnLoad<DiagnosisEntity>(
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
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
