import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/gen/assets.gen.dart';

enum CoreTab {
  home,
  diagnose,
  scan,
  store,
  profile;

  String get bottomNavTitle {
    return '${name}_bottom_nav_name'.tr();
  }

  Widget icon(bool isActive) {
    switch (this) {
      case CoreTab.home:
        return (isActive ? Assets.svg.icLeafActive : Assets.svg.icLeafInactive)
            .svg(height: 32.h, width: 32.h);
      case CoreTab.diagnose:
        return (isActive
                ? Assets.svg.icDiagnoseActive
                : Assets.svg.icDiagnoseInactive)
            .svg(height: 32.h, width: 32.h);
      case CoreTab.store:
        return (isActive
                ? Assets.svg.icStoreActive
                : Assets.svg.icStoreInactive)
            .svg(height: 32.h, width: 32.h);
      case CoreTab.profile:
        return (isActive
            ? Assets.svg.icUserActive
            : Assets.svg.icUserInactive).svg(height: 32.h, width: 32.h);
      default:
        return SizedBox(height: 32.h);
    }
  }
}
