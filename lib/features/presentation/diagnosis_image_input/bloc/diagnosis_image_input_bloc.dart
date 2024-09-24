import 'dart:io';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';
import 'package:smart_garden/features/domain/repository/diagnosis_repository.dart';

part 'diagnosis_image_input_event.dart';

part 'diagnosis_image_input_state.dart';

part 'diagnosis_image_input_bloc.freezed.dart';

part 'diagnosis_image_input_bloc.g.dart';

@injectable
class DiagnosisImageInputBloc
    extends BaseBloc<DiagnosisImageInputEvent, DiagnosisImageInputState> {
  DiagnosisImageInputBloc(this._repository)
      : super(DiagnosisImageInputState.init()) {
    on<DiagnosisImageInputEvent>((event, emit) async {
      await event.when(uploadImage: (image) => _uploadImage(emit, image));
    });
  }

  final DiagnosisRepository _repository;

  Future _uploadImage(
      Emitter<DiagnosisImageInputState> emit, XFile image) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.loading,
        image: File(image.path),
      ),
    );
    final res = await _repository.predictDisease(
      image: File(image.path),
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
