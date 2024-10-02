import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/common/analytic/enum/screen_class_type.dart';
import 'package:smart_garden/common/analytic/model/analytics_params.dart';
import 'package:smart_garden/di/di_setup.dart';

@singleton
class FirebaseAnalyticsService {
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  //set analytics enabled
  Future<void> setAnalyticsEnabled(bool enabled) async {
    await firebaseAnalytics.setAnalyticsCollectionEnabled(enabled);
  }

  //set user id
  Future<void> setUserId(String? userId) async {
    await firebaseAnalytics.setUserId(id: userId);
    logger.i('set user id: $userId');
  }

  //clear user id
  Future<void> clearUserId() async {
    await firebaseAnalytics.setUserId(id: null);
    logger.i('clear user id');
  }

  Future<void> logEvent({
    required AnalyticsEvent event,
  }) async {
    await firebaseAnalytics.logEvent(
      name: event.name.value,
      parameters: event.params.toJson(),
    );
  }

  Future<void> logScreen({
    required ScreenViewType screen,
  }) async {
    await firebaseAnalytics.logScreenView(
      screenName: screen.screenName,
      screenClass: screen.screenClass,
    );
  }

  FirebaseAnalyticsObserver getObserver() {
    return FirebaseAnalyticsObserver(analytics: firebaseAnalytics);
  }
}