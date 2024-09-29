import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/gen/assets.gen.dart';

class HumidityWidget extends StatelessWidget {
  final double? humidity;

  const HumidityWidget({
    super.key,
    this.humidity,
  });

  Color get color {
    if (humidity == null || humidity! < 20) {
      return AppColors.humidity1;
    } else if (humidity! < 40) {
      return AppColors.humidity2;
    } else if (humidity! < 60) {
      return AppColors.humidity3;
    } else if (humidity! < 80) {
      return AppColors.humidity4;
    } else {
      return AppColors.humidity5;
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
          Assets.svg.icHumidity.svg(
            width: 50.w,
            height: 50.h,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'humidity'.tr(),
                style: AppTextStyles.s16w600.copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                '${humidity?.toStringAsFixed(0)}%',
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
