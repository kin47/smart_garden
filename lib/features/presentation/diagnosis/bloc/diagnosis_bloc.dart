import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/features/domain/enum/diagnosis_tab.dart';

part 'diagnosis_event.dart';
part 'diagnosis_state.dart';
part 'diagnosis_bloc.freezed.dart';
part 'diagnosis_bloc.g.dart';

@injectable
class DiagnosisBloc extends BaseBloc<DiagnosisEvent, DiagnosisState> {
  DiagnosisBloc() : super(DiagnosisState.init()) {
    on<DiagnosisEvent>((event, emit) {
      event.when(
        changeTab: (tabType) => onChangeTab(tabType, emit),
      );
    });
  }

  onChangeTab(DiagnosisTab tabType, Emitter<DiagnosisState> emit) {
    if (state.activeTab != tabType) {
      emit(
        state.copyWith(
          activeTab: tabType,
        ),
      );
    }
  }
}
