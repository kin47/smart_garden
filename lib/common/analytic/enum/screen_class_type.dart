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
  profile(
    screenName: 'profile',
    screenClass: 'home',
    routeName: ProfileRoute.name,
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
