import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_garden/routes/app_pages.gr.dart';

enum MyKitTab {
  kitController,
  kitEnvironment,
  weather;

  String get path => '${name}_myKit';

  String get label {
    switch (this) {
      case MyKitTab.kitController:
        return 'control'.tr();
      case MyKitTab.kitEnvironment:
        return 'environment'.tr();
      case MyKitTab.weather:
        return 'weather'.tr();
    }
  }

  PageInfo get pageInfo {
    switch (this) {
      case MyKitTab.kitController:
        return KitControllerRoute.page;
      case MyKitTab.kitEnvironment:
        return KitEnvironmentRoute.page;
      case MyKitTab.weather:
        return WeatherRoute.page;
    }
  }

  static MyKitTab get defaultRoute => MyKitTab.kitController;

  static List<AutoRoute> get routes => [
        RedirectRoute(
          path: '',
          redirectTo: MyKitTab.defaultRoute.path,
        ),
        ...MyKitTab.values.map(
          (tab) => AutoRoute(
            path: tab.path,
            page: tab.pageInfo,
            maintainState: tab != MyKitTab.weather,
          ),
        ),
      ];
}
