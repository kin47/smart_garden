import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/data/request/connect_to_kit_request/connect_to_kit_request.dart';
import 'package:smart_garden/features/domain/entity/kit_entity.dart';
import 'package:smart_garden/features/domain/events/event_bus_event.dart';
import 'package:smart_garden/features/domain/repository/kit_repository.dart';

part 'kit_connect_event.dart';

part 'kit_connect_state.dart';

part 'kit_connect_bloc.freezed.dart';

part 'kit_connect_bloc.g.dart';

@injectable
class KitConnectBloc extends BaseBloc<KitConnectEvent, KitConnectState> {
  KitConnectBloc(this._kitRepository) : super(KitConnectState.initial()) {
    on<KitConnectEvent>((event, emit) async {
      await event.when(
        init: (id) => _init(emit, id),
        onPasswordVisibilityChanged: (isVisible) =>
            _passwordVisibilityChanged(emit, isVisible),
        connect: (password) => _connectToKit(emit, password),
      );
    });
  }

  final KitRepository _kitRepository;

  Future _init(Emitter<KitConnectState> emit, int id) async {
    emit(state.copyWith(status: BaseStateStatus.loading, id: id));
    final result = await _kitRepository.getKitDetail(kitId: id);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          isErrorFromGetKitDetail: true,
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

  Future _passwordVisibilityChanged(
    Emitter<KitConnectState> emit,
    bool isVisible,
  ) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        isPasswordVisible: isVisible,
      ),
    );
  }

  Future _connectToKit(Emitter<KitConnectState> emit, String password) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final result = await _kitRepository.connectToKit(
      request: ConnectToKitRequest(
        kitId: state.id,
        password: password,
      ),
    );
    await result.fold(
      (l) async => emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: l.getError,
        ),
      ),
      (r) async {
        await getIt<LocalStorage>().save(KitConstants.kitId, state.id);
        emit(
          state.copyWith(
            status: BaseStateStatus.success,
          ),
        );
        getIt<EventBus>().fire(const RefreshHomeDataEvent());
      },
    );
  }
}
