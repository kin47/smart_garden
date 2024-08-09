import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/gen/assets.gen.dart';
import 'package:smart_garden/routes/app_pages.gr.dart';

enum CoreTab {
  home,
  diagnose,
  scan,
  store,
  profile;

  String get path => name;

  String get title {
    return '${name}_bottom_nav_name'.tr();
  }

  PageRouteInfo<dynamic> get pageRouteInfo {
    switch (this) {
      case CoreTab.home:
        return const HomeRoute();
      case CoreTab.diagnose:
        return const DiagnosisRoute();
      case CoreTab.scan:
        return const ProfileRoute();
      case CoreTab.store:
        return const StoreRoute();
      case CoreTab.profile:
        return const ProfileRoute();
    }
  }

  static CoreTab get defaultRoute => CoreTab.home;

  static List<AutoRoute> get routes => [
        RedirectRoute(path: '', redirectTo: CoreTab.defaultRoute.path),
        ...CoreTab.values.map(
          (tab) => AutoRoute(
            path: tab.path,
            page: tab.pageInfo,
          ),
        ),
      ];

  PageInfo get pageInfo {
    switch (this) {
      case CoreTab.home:
        return HomeRoute.page;
      case CoreTab.diagnose:
        return DiagnosisRoute.page;
      case CoreTab.store:
        return StoreRoute.page;
      case CoreTab.profile:
        return ProfileRoute.page;
      default:
        return HomeRoute.page;
    }
  }

  Widget icon(bool isActive) {
    switch (this) {
      case CoreTab.home:
        return (isActive ? Assets.svg.icLeafActive : Assets.svg.icLeafInactive)
            .svg(width: 28.w);
      case CoreTab.diagnose:
        return (isActive
                ? Assets.svg.icDiagnoseActive
                : Assets.svg.icDiagnoseInactive)
            .svg(width: 28.w);
      case CoreTab.store:
        return (isActive
                ? Assets.svg.icStoreActive
                : Assets.svg.icStoreInactive)
            .svg(width: 28.w);
      case CoreTab.profile:
        return (isActive ? Assets.svg.icUserActive : Assets.svg.icUserInactive)
            .svg(width: 28.w);
      default:
        return SizedBox(width: 28.w, height: 24.w);
    }
  }
}
