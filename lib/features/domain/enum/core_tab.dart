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
        return (isActive
            ? Assets.svg.icUserActive
            : Assets.svg.icUserInactive).svg(width: 28.w);
      default:
        return SizedBox(width: 28.w, height: 28.h);
    }
  }
}
