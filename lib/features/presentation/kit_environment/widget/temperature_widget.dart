import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/gen/assets.gen.dart';

class TemperatureWidget extends StatelessWidget {
  final double temperature;

  const TemperatureWidget({
    super.key,
    required this.temperature,
  });

  Color get color {
    if (temperature <= 5) {
      return AppColors.white;
    } else if (temperature <= 20) {
      return AppColors.temperature2;
    } else if (temperature < 30) {
      return AppColors.temperature3;
    } else if (temperature < 40) {
      return AppColors.temperature4;
    } else {
      return AppColors.temperature5;
    }
  }

  Color get textColor {
    if (temperature < 30) {
      return AppColors.black;
    } else {
      return AppColors.white;
    }
  }

  Color get iconColor {
    if (temperature < 30) {
      return AppColors.temperature5;
    } else {
      return AppColors.white;
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
          Assets.svg.icHighTemperature.svg(
            width: 50.w,
            height: 50.h,
            colorFilter: ColorFilter.mode(
              iconColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'temperature'.tr(),
                style: AppTextStyles.s16w600.copyWith(
                  color: textColor,
                ),
              ),
              Text(
                '${temperature.toStringAsFixed(1)}°C',
                style: AppTextStyles.s24w600.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
