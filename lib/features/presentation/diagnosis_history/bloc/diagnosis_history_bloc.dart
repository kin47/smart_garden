import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';

part 'diagnosis_history_event.dart';
part 'diagnosis_history_state.dart';
part 'diagnosis_history_bloc.freezed.dart';
part 'diagnosis_history_bloc.g.dart';

@injectable
class DiagnosisHistoryBloc extends BaseBloc<DiagnosisHistoryEvent, DiagnosisHistoryState> {
  DiagnosisHistoryBloc() : super(DiagnosisHistoryState.init()) {
    on<DiagnosisHistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
