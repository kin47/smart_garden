import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/common/logger/logger.dart';

import 'di_setup.config.dart';

final GetIt getIt = GetIt.instance;
final logger = getIt<LogUtils>();

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies({String env = Environment.dev}) =>
    $initGetIt(getIt, environment: env);
