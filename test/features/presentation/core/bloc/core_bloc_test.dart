import 'package:flutter_test/flutter_test.dart';
import 'package:smart_garden/common/local_data/shared_pref.dart';
import 'package:smart_garden/common/logger/logger.dart';
import 'package:smart_garden/features/presentation/core/bloc/core_bloc.dart';
import 'package:smart_garden/features/domain/enum/core_tab.dart';
import 'package:smart_garden/features/domain/repository/chat_repository.dart';
import 'package:smart_garden/features/domain/repository/device_token_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:get_it/get_it.dart';

import 'core_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DeviceTokenRepository>(),
  MockSpec<ChatRepository>(),
  MockSpec<LocalStorage>(),
])
void main() {
  final sl = GetIt.instance;
  late MockDeviceTokenRepository deviceTokenRepository;
  late MockChatRepository chatRepository;
  late MockLocalStorage localStorage;
  late CoreBloc coreBloc;

  setUp(() {
    deviceTokenRepository = MockDeviceTokenRepository();
    chatRepository = MockChatRepository();
    localStorage = MockLocalStorage();

    // Register the mock in GetIt
    sl.registerSingleton<LocalStorage>(localStorage);
    sl.registerSingleton<LogUtils>(LogUtils());

    coreBloc = CoreBloc(deviceTokenRepository, chatRepository);
  });

  tearDown(() async {
    await coreBloc.close();
    sl.reset(); // This clears all registrations
  });
  blocTest<CoreBloc, CoreState>(
    'emits nothing when changeTab is called with the same tab',
    build: () => coreBloc,
    act: (bloc) => bloc.add(CoreEvent.changeTab(CoreTab.home)),
    expect: () => <CoreState>[],
  );

  blocTest<CoreBloc, CoreState>(
    'emits new state when changeTab is called with a different tab',
    build: () => coreBloc,
    seed: () => CoreState.init().copyWith(activeTab: CoreTab.home),
    act: (bloc) => bloc.add(CoreEvent.changeTab(CoreTab.profile)),
    expect: () => [
      CoreState.init().copyWith(activeTab: CoreTab.profile),
    ],
  );
}
