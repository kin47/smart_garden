import 'dart:io';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';

part 'diagnosis_image_input_event.dart';
part 'diagnosis_image_input_state.dart';
part 'diagnosis_image_input_bloc.freezed.dart';
part 'diagnosis_image_input_bloc.g.dart';

@injectable
class DiagnosisImageInputBloc extends BaseBloc<DiagnosisImageInputEvent, DiagnosisImageInputState> {
  DiagnosisImageInputBloc() : super(DiagnosisImageInputState.init()) {
    on<DiagnosisImageInputEvent>((event, emit) {
    });
  }
}
