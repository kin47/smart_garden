import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/data/request/control_kit_request/control_kit_request.dart';
import 'package:smart_garden/features/domain/repository/kit_repository.dart';

part 'kit_controller_event.dart';

part 'kit_controller_state.dart';

part 'kit_controller_bloc.freezed.dart';

part 'kit_controller_bloc.g.dart';

@injectable
class KitControllerBloc
    extends BaseBloc<KitControllerEvent, KitControllerState> {
  KitControllerBloc(this._kitRepository) : super(KitControllerState.init()) {
    on<KitControllerEvent>(
      (event, emit) async {
        await event.when(
          init: () => _init(emit),
          toggleLightManual: (isLightOn) => _toggleLightManual(emit, isLightOn),
          togglePumpManual: (isPumpOn) => _togglePumpManual(emit, isPumpOn),
          toggleAutoLight: (autoLight) => _toggleAutoLight(emit, autoLight),
          toggleAutoPump: (autoPump) => _toggleAutoPump(emit, autoPump),
          changeLightThreshold: (lightThreshold) => null,
          changePumpThreshold: (pumpThreshold) => null,
        );
      },
    );
    on<ChangeLightThreshold>(
      (event, emit) async {
        await _changeLightThreshold(emit, event.lightThreshold);
      },
      transformer: (events, mapper) => events.debounceTime(
        const Duration(milliseconds: 300),
      ),
    );
    on<ChangePumpThreshold>(
      (event, emit) async {
        await _changePumpThreshold(emit, event.pumpThreshold);
      },
      transformer: (events, mapper) => events.debounceTime(
        const Duration(milliseconds: 300),
      ),
    );
  }

  final KitRepository _kitRepository;

  Future _init(Emitter<KitControllerState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final kitId =
        await getIt<LocalStorage>().get<int>(KitConstants.kitId) ?? -1;
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
          autoLight: r.isAutoLight,
          autoPump: r.isAutoPump,
          lightThreshold: r.lightThreshold,
          pumpThreshold: r.pumpThreshold,
        ),
      ),
    );
  }

  Future _toggleLightManual(
      Emitter<KitControllerState> emit, bool isLightOn) async {
    if (state.autoLight) {
      emit(
        state.copyWith(
          status: BaseStateStatus.showPopUp,
          message: 'please_turn_off_auto_mode'.tr(),
        ),
      );
      emit(state.copyWith(status: BaseStateStatus.idle));
      return;
    }
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        isLightOn: isLightOn,
      ),
    );
    final res = await _kitRepository.controlKit(
      kitId: state.kitId,
      request: ControlKitRequest(
        turnOnLight: isLightOn,
      ),
    );
    res.fold(
      (l) => emit(
        state.copyWith(
          message: l.getError,
          status: BaseStateStatus.failed,
          isLightOn: !isLightOn,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
        ),
      ),
    );
  }

  Future _togglePumpManual(
    Emitter<KitControllerState> emit,
    bool isPumpOn,
  ) async {
    if (state.autoPump) {
      emit(
        state.copyWith(
          status: BaseStateStatus.showPopUp,
          message: 'please_turn_off_auto_mode'.tr(),
        ),
      );
      emit(state.copyWith(status: BaseStateStatus.idle));
      return;
    }

    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        isPumpOn: isPumpOn,
      ),
    );

    final res = await _kitRepository.controlKit(
      kitId: state.kitId,
      request: ControlKitRequest(
        turnOnPump: isPumpOn,
      ),
    );
    res.fold(
      (l) => emit(
        state.copyWith(
          message: l.getError,
          status: BaseStateStatus.failed,
          isPumpOn: !isPumpOn,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
        ),
      ),
    );
  }

  Future _toggleAutoLight(
    Emitter<KitControllerState> emit,
    bool autoLight,
  ) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        autoLight: autoLight,
        isLightOn: false,
      ),
    );
    final res = await _kitRepository.controlKit(
      kitId: state.kitId,
      request: ControlKitRequest(
        isAutoLight: autoLight,
        turnOnLight: false,
      ),
    );
    res.fold(
      (l) => emit(
        state.copyWith(
          message: l.getError,
          status: BaseStateStatus.failed,
          autoLight: !autoLight,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
        ),
      ),
    );
  }

  Future _toggleAutoPump(
      Emitter<KitControllerState> emit, bool autoPump) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        autoPump: autoPump,
        isPumpOn: false,
      ),
    );
    final res = await _kitRepository.controlKit(
      kitId: state.kitId,
      request: ControlKitRequest(
        isAutoPump: autoPump,
        turnOnPump: false,
      ),
    );
    res.fold(
      (l) => emit(
        state.copyWith(
          message: l.getError,
          status: BaseStateStatus.failed,
          autoPump: !autoPump,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
        ),
      ),
    );
  }

  Future _changeLightThreshold(
      Emitter<KitControllerState> emit, int lightThreshold) async {
    if (!state.autoLight) {
      emit(
        state.copyWith(
          status: BaseStateStatus.showPopUp,
          message: 'please_turn_on_auto_mode'.tr(),
        ),
      );
      emit(state.copyWith(status: BaseStateStatus.idle));
      return;
    }
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        lightThreshold: lightThreshold,
      ),
    );
    final res = await _kitRepository.controlKit(
      kitId: state.kitId,
      request: ControlKitRequest(
        lightThreshold: lightThreshold,
      ),
    );
    res.fold(
      (l) => emit(
        state.copyWith(
          message: l.getError,
          status: BaseStateStatus.failed,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
        ),
      ),
    );
  }

  Future _changePumpThreshold(
      Emitter<KitControllerState> emit, int pumpThreshold) async {
    if (!state.autoPump) {
      emit(
        state.copyWith(
          status: BaseStateStatus.showPopUp,
          message: 'please_turn_on_auto_mode'.tr(),
        ),
      );
      emit(state.copyWith(status: BaseStateStatus.idle));
      return;
    }
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        pumpThreshold: pumpThreshold,
      ),
    );
    final res = await _kitRepository.controlKit(
      kitId: state.kitId,
      request: ControlKitRequest(
        pumpThreshold: pumpThreshold,
      ),
    );
    res.fold(
      (l) => emit(
        state.copyWith(
          message: l.getError,
          status: BaseStateStatus.failed,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
        ),
      ),
    );
  }
}
