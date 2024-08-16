import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';
part 'splash_bloc.g.dart';

@injectable
class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc(
    this._authRepository,
  ) : super(SplashState.init()) {
    on<SplashEvent>((event, emit) async {
      await event.when(
        init: () => init(emit),
      );
    });
  }

  final AuthRepository _authRepository;

  Future init(Emitter<SplashState> emit) async {
    final res = await _authRepository.getUserInfo();
    res.fold(
      (l) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
          actionState: SplashActionState.goToLogin,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.success,
          actionState: SplashActionState.goToHome,
          user: r,
        ),
      ),
    );
  }
}
