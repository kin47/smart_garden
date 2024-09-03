import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';

part 'kit_controller_event.dart';

part 'kit_controller_state.dart';

part 'kit_controller_bloc.freezed.dart';

part 'kit_controller_bloc.g.dart';

@injectable
class KitControllerBloc
    extends BaseBloc<KitControllerEvent, KitControllerState> {
  KitControllerBloc() : super(KitControllerState.init()) {
    on<KitControllerEvent>(
      (event, emit) async {
        await event.when(
          init: () => _init(emit),
          toggleLightManual: (isLightOn) => _toggleLightManual(emit, isLightOn),
          togglePumpManual: (isPumpOn) => _togglePumpManual(emit, isPumpOn),
          toggleAutoLight: (autoLight) => _toggleAutoLight(emit, autoLight),
          toggleAutoPump: (autoPump) => _toggleAutoPump(emit, autoPump),
          changeLightThreshold: (lightThreshold) =>
              _changeLightThreshold(emit, lightThreshold),
          changePumpThreshold: (pumpThreshold) =>
              _changePumpThreshold(emit, pumpThreshold),
        );
      },
    );
  }

  Future _init(Emitter<KitControllerState> emit) async {}

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
  }

  Future _togglePumpManual(
      Emitter<KitControllerState> emit, bool isPumpOn) async {
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
  }

  Future _toggleAutoLight(
      Emitter<KitControllerState> emit, bool autoLight) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        autoLight: autoLight,
        isLightOn: false,
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
  }
}
