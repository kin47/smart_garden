import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/utils/functions/common_functions.dart';
import 'package:smart_garden/common/widgets/cache_image_widget.dart';
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';

@RoutePage()
class DiagnosisResultPage extends StatefulWidget {
  final DiagnosisEntity? diagnosis;

  const DiagnosisResultPage({
    super.key,
    this.diagnosis,
  });

  @override
  State<DiagnosisResultPage> createState() => _DiagnosisResultPageState();
}

class _DiagnosisResultPageState extends State<DiagnosisResultPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'diagnosis_result'.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageWidget(
              url: widget.diagnosis?.imageUrl ?? '',
              width: 1.sw,
              height: 250.h,
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.diagnosis?.plant ?? '',
                      style: AppTextStyles.s20w700,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    '${'diagnose'.tr()}: ${widget.diagnosis?.disease ?? ''}',
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "${'treatment'.tr()}:",
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    widget.diagnosis?.treatment ?? '',
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    '${'reference'.tr()}:',
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await launchLink(
                          "https://www.hoptri.com/quy-trinh-giai-phap/cay-trong-khac/phong-tru-benh-hai-cay-ca-chua");
                    },
                    child: Text(
                      widget.diagnosis?.reference ?? '',
                      style: AppTextStyles.s14w400.copyWith(
                        color: AppColors.textLink,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textLink,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
