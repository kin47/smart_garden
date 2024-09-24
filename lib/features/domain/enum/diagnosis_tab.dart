import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_garden/routes/app_pages.gr.dart';

enum DiagnosisTab {
  imageInput,
  history;

  String get path => '${name}_diagnosis';

  String get label {
    switch (this) {
      case DiagnosisTab.imageInput:
        return 'disease_detection'.tr();
      case DiagnosisTab.history:
        return 'diagnose_history'.tr();
    }
  }

  PageInfo get pageInfo {
    switch (this) {
      case DiagnosisTab.imageInput:
        return DiagnosisImageInputRoute.page;
      case DiagnosisTab.history:
        return DiagnosisHistoryRoute.page;
    }
  }

  static DiagnosisTab get defaultRoute => DiagnosisTab.imageInput;

  static List<AutoRoute> get routes => [
        RedirectRoute(
          path: '',
          redirectTo: DiagnosisTab.defaultRoute.path,
        ),
        ...DiagnosisTab.values.map(
          (tab) => AutoRoute(
            path: tab.path,
            page: tab.pageInfo,
            maintainState: tab != DiagnosisTab.history,
          ),
        ),
      ];
}
