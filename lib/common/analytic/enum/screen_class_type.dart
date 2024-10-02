import 'package:flutter/material.dart';
import 'package:smart_garden/routes/app_pages.gr.dart';
import 'package:collection/collection.dart';

enum ScreenViewType {
  splash(
    screenName: 'splash',
    screenClass: 'splash',
    routeName: SplashRoute.name,
  ),
  login(
    screenName: 'login',
    screenClass: 'login',
    routeName: LoginRoute.name,
  ),
  newAccount(
    screenName: 'new_account',
    screenClass: 'login',
    routeName: RegisterRoute.name,
  ),
  home(
    screenName: 'home',
    screenClass: 'home',
    routeName: HomeRoute.name,
  ),
  notification(
    screenName: 'notification-list',
    screenClass: 'notification',
    routeName: NotificationListRoute.name,
  ),
  inputDiseaseImage(
    screenName: 'input_disease_image',
    screenClass: 'disease-diagnosis',
    routeName: DiagnosisImageInputRoute.name,
  ),
  diagnosisPage(
    screenName: 'diagnosis_page',
    screenClass: 'disease-diagnosis',
    routeName: DiagnosisRoute.name,
  ),
  diagnosisResult(
    screenName: 'diagnosis_result',
    screenClass: 'disease-diagnosis',
    routeName: DiagnosisResultRoute.name,
  ),
  diagnosisHistory(
    screenName: 'diagnosis_history',
    screenClass: 'disease-diagnosis',
    routeName: DiagnosisHistoryRoute.name,
  ),
  store(
    screenName: 'store',
    screenClass: 'store',
    routeName: StoreRoute.name,
  ),
  chat(
    screenName: 'chat',
    screenClass: 'chat',
    routeName: ChatRoute.name,
  ),
  myKit(
    screenName: 'my_kit',
    screenClass: 'kit',
    routeName: MyKitRoute.name,
  ),
  kitController(
    screenName: 'kit-controller',
    screenClass: 'kit',
    routeName: KitControllerRoute.name,
  ),
  kitEnvironment(
    screenName: 'kit-environment',
    screenClass: 'kit',
    routeName: KitEnvironmentRoute.name,
  ),
  weather(
    screenName: 'weather',
    screenClass: 'kits',
    routeName: WeatherRoute.name,
  ),
  profile(
    screenName: 'profile',
    screenClass: 'profile',
    routeName: ProfileRoute.name,
  );

  const ScreenViewType({
    required this.screenName,
    required this.screenClass,
    required this.routeName,
  });

  final String screenName;
  final String screenClass;
  final String routeName;

  Map<String, String> get params => {
        'firebase_screen': screenName,
        'firebase_screen_class': screenClass,
      };

  static ScreenViewType? fromRoute(String routeName, {Route? routes}) {
    return ScreenViewType.values.firstWhereOrNull(
      (element) => element.routeName == routeName,
    );
  }
}
