import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';
import 'package:smart_garden/features/domain/repository/diagnosis_repository.dart';

part 'diagnosis_result_event.dart';

part 'diagnosis_result_state.dart';

part 'diagnosis_result_bloc.freezed.dart';

part 'diagnosis_result_bloc.g.dart';

@injectable
class DiagnosisResultBloc
    extends BaseBloc<DiagnosisResultEvent, DiagnosisResultState> {
  DiagnosisResultBloc(this._diagnosisRepository)
      : super(DiagnosisResultState.init()) {
    on<DiagnosisResultEvent>((event, emit) async {
      await event.when(
        getData: (id) => _getData(id, emit),
      );
    });
  }

  final DiagnosisRepository _diagnosisRepository;

  Future _getData(int id, Emitter<DiagnosisResultState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final res = await _diagnosisRepository.getDiagnosisDetail(
      id: id,
    );
    res.fold(
      (l) => emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: l.getError,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.success,
          diagnosis: r,
        ),
      ),
    );
  }
}
