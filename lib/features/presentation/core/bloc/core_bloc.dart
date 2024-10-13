import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/index.dart';
import 'package:smart_garden/common/constants/auth_constants.dart';
import 'package:smart_garden/common/local_data/secure_storage.dart';
import 'package:smart_garden/common/notification/index.dart';
import 'package:smart_garden/common/utils/functions/jwt_decode.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/data/request/connect_ws_request/connect_ws_request.dart';
import 'package:smart_garden/features/data/request/device_token_request/device_token_request.dart';
import 'package:smart_garden/features/domain/enum/core_tab.dart';
import 'package:smart_garden/features/domain/repository/chat_repository.dart';
import 'package:smart_garden/features/domain/repository/device_token_repository.dart';

part 'core_event.dart';

part 'core_state.dart';

part 'core_bloc.freezed.dart';

part 'core_bloc.g.dart';

@injectable
class CoreBloc extends BaseBloc<CoreEvent, CoreState> {
  CoreBloc(
    this._deviceTokenRepository,
    this._chatRepository,
  ) : super(CoreState.init()) {
    on<CoreEvent>((event, emit) async {
      await event.when(
        init: () => onInit(emit),
        registerDeviceToken: () => registerDeviceToken(),
        initializeWebSocket: () {},
        changeTab: (tabType) => onChangeTab(tabType, emit),
      );
    });
  }

  final DeviceTokenRepository _deviceTokenRepository;
  final ChatRepository _chatRepository;

  Future onInit(Emitter<CoreState> emit) async {
    await Future.wait([
      registerDeviceToken(),
      initializeWebSocket(),
    ]);
  }

  Future registerDeviceToken() async {
    final res = await _deviceTokenRepository.registerDeviceToken(
      request: DeviceTokenRequest(
        deviceToken: await getIt<PushNotificationHelper>().getPushToken() ?? "",
      ),
    );
    res.fold(
      (l) => logger.e('Can not register device token'),
      (r) => logger.i('Register device token success'),
    );
  }

  Future initializeWebSocket() async {
    final accessToken = await getIt<SecureStorage>().get(AuthConstants.token);
    final jwtModel = JwtDecoder.tryDecode(accessToken ?? '');
    if (jwtModel != null) {
      _chatRepository.chatInitialize(
        connectRequest: ConnectWSRequest(
          userId: jwtModel.userId ?? 0,
        ),
      );
    }
  }

  Future onChangeTab(CoreTab tabType, Emitter<CoreState> emit) async {
    if (tabType != state.activeTab && tabType != CoreTab.scan) {
      emit(
        state.copyWith(
          activeTab: tabType,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _chatRepository.disconnectChat();
    logger.d('CoreBloc closed');
    return super.close();
  }
}
