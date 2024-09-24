import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/widgets/buttons/app_button.dart';
import 'package:smart_garden/features/presentation/diagnosis_image_input/bloc/diagnosis_image_input_bloc.dart';
import 'package:smart_garden/features/presentation/diagnosis_image_input/widget/predicting_disease_dialog.dart';
import 'package:smart_garden/gen/assets.gen.dart';
import 'package:smart_garden/routes/app_pages.gr.dart';

@RoutePage()
class DiagnosisImageInputPage extends StatefulWidget {
  const DiagnosisImageInputPage({super.key});

  @override
  State<DiagnosisImageInputPage> createState() =>
      _DiagnosisImageInputPageState();
}

class _DiagnosisImageInputPageState extends BaseState<
    DiagnosisImageInputPage,
    DiagnosisImageInputEvent,
    DiagnosisImageInputState,
    DiagnosisImageInputBloc> {
  final ImagePicker picker = ImagePicker();

  @override
  void listener(BuildContext context, DiagnosisImageInputState state) {
    switch (state.status) {
      case BaseStateStatus.loading:
        DialogService.showCustomDialog(
          context,
          PredictingDiseaseDialog(
            image: state.image ?? File(''),
          ),
        );
        break;
      case BaseStateStatus.success:
        // Close the loading dialog
        Navigator.of(context).pop();
        context.router.push(DiagnosisResultRoute(
          diagnosis: state.diagnosis,
        ));
        break;
      case BaseStateStatus.failed:
        // Close the loading dialog
        Navigator.of(context).pop();
        DialogService.showInformationDialog(
          context,
          description: state.message,
        );
        break;
      default:
        DialogService.hideLoading();
        break;
    }
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svg.icPlantDiseaseDetection.svg(
            width: 1.sw,
          ),
          Text(
            'diagnosis_image_input_page_description'.tr(),
            style: AppTextStyles.s14w400,
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppButton(
              onPressed: () async {
                final image =
                    await picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  bloc.add(DiagnosisImageInputEvent.uploadImage(image: image));
                }
              },
              title: 'take_picture'.tr(),
              childGap: 8.w,
              leadingIcon: Icon(
                Icons.camera_alt_rounded,
                size: 24.w,
                color: AppColors.white,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppButton(
              onPressed: () async {
                final image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  bloc.add(DiagnosisImageInputEvent.uploadImage(image: image));
                }
              },
              isOutlined: true,
              borderRadius: 16.r,
              backgroundColor: Colors.transparent,
              borderColor: AppColors.primary700,
              textColor: AppColors.primary700,
              title: 'choose_from_library'.tr(),
              childGap: 8.w,
              leadingIcon: Icon(
                Icons.image_outlined,
                size: 24.w,
                color: AppColors.primary700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
