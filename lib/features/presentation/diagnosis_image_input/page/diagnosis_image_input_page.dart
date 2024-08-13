import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/widgets/buttons/app_button.dart';
import 'package:smart_garden/features/presentation/diagnosis_history/bloc/diagnosis_history_bloc.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class DiagnosisImageInputPage extends StatefulWidget {
  const DiagnosisImageInputPage({super.key});

  @override
  State<DiagnosisImageInputPage> createState() =>
      _DiagnosisImageInputPageState();
}

class _DiagnosisImageInputPageState extends BaseState<DiagnosisImageInputPage,
    DiagnosisHistoryEvent, DiagnosisHistoryState, DiagnosisHistoryBloc> {
  final ImagePicker picker = ImagePicker();

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
                await picker.pickImage(source: ImageSource.camera);
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
                await picker.pickImage(source: ImageSource.gallery);
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
