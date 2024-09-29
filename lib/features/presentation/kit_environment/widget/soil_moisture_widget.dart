import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/gen/assets.gen.dart';

class SoilMoistureWidget extends StatelessWidget {
  final double? soilMoisture;

  const SoilMoistureWidget({
    super.key,
    this.soilMoisture,
  });

  Color get color {
    if (soilMoisture == null || soilMoisture! < 10) {
      return AppColors.soilMoisture1;
    } else if (soilMoisture! < 30) {
      return AppColors.soilMoisture2;
    } else if (soilMoisture! < 50) {
      return AppColors.soilMoisture3;
    } else if (soilMoisture! < 70) {
      return AppColors.soilMoisture4;
    } else {
      return AppColors.soilMoisture5;
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
          Assets.svg.icLeafActive.svg(
            width: 50.w,
            height: 50.h,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'soil_moisture'.tr(),
                style: AppTextStyles.s16w600.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                '${soilMoisture?.toStringAsFixed(0)}%',
                style: AppTextStyles.s24w600.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
