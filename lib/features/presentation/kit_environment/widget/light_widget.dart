import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/gen/assets.gen.dart';

class LightWidget extends StatelessWidget {
  final double light;

  const LightWidget({
    super.key,
    required this.light,
  });

  Color get color {
    if (light < 10) {
      return AppColors.light1;
    } else if (light < 100) {
      return AppColors.light2;
    } else if (light < 500) {
      return AppColors.light3;
    } else if (light < 1000) {
      return AppColors.light4;
    } else {
      return AppColors.light5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Assets.images.lightBulbOff.image(
            width: 50.w,
            height: 50.h,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'light'.tr(),
                style: AppTextStyles.s16w600.copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                '${light.toStringAsFixed(0)} lux',
                style: AppTextStyles.s24w600.copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
