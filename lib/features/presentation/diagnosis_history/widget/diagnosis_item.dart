import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/common/widgets/cache_image_widget.dart';
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';

class DiagnosisItem extends StatelessWidget {
  final DiagnosisEntity diagnosis;

  const DiagnosisItem({
    super.key,
    required this.diagnosis,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          CachedImageWidget(
            url: diagnosis.imageUrl,
            width: 70.w,
            height: 70.w,
            radius: 8.r,
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                diagnosis.plant,
                style: AppTextStyles.s16w600,
              ),
              Text(
                diagnosis.disease,
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.red,
                ),
              ),
              Text(
                diagnosis.date.toString(),
                style: AppTextStyles.s12w300.copyWith(
                  color: AppColors.gray500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.gray500,
            size: 24.w,
          ),
        ],
      ),
    );
  }
}
