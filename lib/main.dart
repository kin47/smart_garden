import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:smart_garden/common/analytic/firebase_analytics_service.dart';
import 'package:smart_garden/common/constants/other_constants.dart';
import 'package:smart_garden/common/mqtt/mqtt_app_state.dart';
import 'package:smart_garden/common/notification/push_notification_helper.dart';
import 'package:smart_garden/common/utils/dialog/loading_widget.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/routes/firebase_analytic_route_observer.dart';

import 'common/config/screen_utils_config.dart';
import 'firebase_options.dart';
import 'routes/app_pages.dart';

String envConfig(String flavor) {
  switch (flavor) {
    case 'dev':
      return 'assets/env/.env_dev';
    case 'staging':
      return 'assets/env/.env_staging';
    case 'production':
      return 'assets/env/.env_production';
    default:
      return 'assets/env/.env_dev';
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const flavor = String.fromEnvironment('flavor', defaultValue: 'dev');
  log("flavor: $flavor");
  await dotenv.load(
    fileName: envConfig(flavor),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await EasyLocalization.ensureInitialized();
  configureDependencies();
  await getIt<PushNotificationHelper>().initialize();
  await getIt<FirebaseAnalyticsService>().setAnalyticsEnabled(true);
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(
    EasyLocalization(
      supportedLocales: const [
        LocalizationConstants.enUSLocale,
        LocalizationConstants.viLocale
      ],
      path: LocalizationConstants.path,
      startLocale: LocalizationConstants.viLocale,
      fallbackLocale: LocalizationConstants.viLocale,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRoute = getIt<AppPages>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        ScreenUtilsConfig.designWidth,
        ScreenUtilsConfig.designHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: FlutterSmartDialog.init(
            loadingBuilder: (msg) => const LoadingWidget(),
            builder: (context, child) => MediaQuery(
              ///Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1),
              ),
              child: ChangeNotifierProvider<MQTTAppState>(
                create: (_) => MQTTAppState(),
                child: child ?? const SizedBox(),
              ),
            ),
          ),
          routerDelegate: _appRoute.delegate(
            navigatorObservers: () => [
              AutoRouteObserver(),
              FirebaseAnalyticsRouteObserver(),
            ]
          ),
          routerConfig: _appRoute.config(),
        );
      },
    );
  }
}
