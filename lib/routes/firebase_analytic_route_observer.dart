import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/common/analytic/firebase_analytics_service.dart';
import 'package:smart_garden/common/analytic/enum/screen_class_type.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/routes/app_pages.dart';

class FirebaseAnalyticsRouteObserver extends AutoRouteObserver {
  final FirebaseAnalyticsService _firebaseAnalyticsService =
  getIt<FirebaseAnalyticsService>();
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      final screenType =
      ScreenViewType.fromRoute(route.settings.name!, routes: route);
      if (screenType != null) {
        _firebaseAnalyticsService.logScreen(screen: screenType);
      }
    }
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log('didInitTabRoute');
    log('Tab route visited: ${route.name}');
    final screenType = ScreenViewType.fromRoute(
      route.name,
    );
    if (screenType != null) {
      _firebaseAnalyticsService.logScreen(screen: screenType);
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log('didChangeTabRoute');
    log('Tab route visited: ${route.name}');
    final screenType = ScreenViewType.fromRoute(
      route.name,
    );
    if (screenType != null) {
      _firebaseAnalyticsService.logScreen(screen: screenType);
    }
  }

  @override
  void didStopUserGesture() {
    log('User gesture stopped');
  }

  @override
  void didStartUserGesture(
      Route<dynamic> route,
      Route<dynamic>? previousRoute,
      ) {
    log('User gesture started');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('didReplace');
    log('Previous route: ${oldRoute?.settings.name}');
    log('Route replaced: ${newRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('didRemove');
    log('Previous route: ${previousRoute?.settings.name}');
    log('Route removed: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('didPop');
    log('Route popped: ${previousRoute?.settings.name}');
    //get root route
    final segments = getIt<AppPages>().root.navigationHistory.urlState.segments;
    if (segments.length < 2) return;
    final destination = segments[segments.length - 1];
    final screenType = ScreenViewType.fromRoute(
      destination.name,
      routes: previousRoute,
    );
    if (screenType != null) {
      _firebaseAnalyticsService.logScreen(screen: screenType);
    }
  }
}