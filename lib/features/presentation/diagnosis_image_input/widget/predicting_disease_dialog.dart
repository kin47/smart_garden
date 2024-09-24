import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/domain/events/event_bus_event.dart';
import 'package:smart_garden/gen/assets.gen.dart';

class PredictingDiseaseDialog extends StatefulWidget {
  final File image;

  const PredictingDiseaseDialog({
    super.key,
    required this.image,
  });

  @override
  State<PredictingDiseaseDialog> createState() =>
      _PredictingDiseaseDialogState();
}

class _PredictingDiseaseDialogState extends State<PredictingDiseaseDialog> {
  final StreamController<double> _percentIndicatorController =
      StreamController<double>();
  late StreamSubscription _eventBusSubscription;

  @override
  void initState() {
    super.initState();
    _eventBusSubscription = getIt<EventBus>().on<UploadFileEvent>().listen((event) {
      // Update the progress
      _percentIndicatorController.add(event.percent);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _eventBusSubscription.cancel();
    _percentIndicatorController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Image.file(
              widget.image,
              width: 1.sw,
              height: 0.4.sh,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Assets.svg.icPlantDiseaseDetection.svg(
                  width: 1.sw,
                );
              },
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                'predicting_disease_dialog_description'.tr(),
                style: AppTextStyles.s14w400,
              ),
            ),
            SizedBox(height: 16.h),
            StreamBuilder<double>(
              stream: _percentIndicatorController.stream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Text(
                      '${snapshot.data?.toStringAsFixed(0) ?? 0}%',
                      style: AppTextStyles.s14w400,
                    ),
                    SizedBox(height: 8.h),
                    LinearProgressIndicator(
                      value: (snapshot.data ?? 0) / 100,
                      borderRadius: BorderRadius.circular(8.r),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary700,
                      ),
                    ),
                  ],
                );
              }
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
