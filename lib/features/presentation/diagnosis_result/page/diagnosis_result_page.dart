import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/utils/functions/common_functions.dart';
import 'package:smart_garden/common/widgets/cache_image_widget.dart';
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';
import 'package:smart_garden/features/presentation/diagnosis_result/bloc/diagnosis_result_bloc.dart';

@RoutePage()
class DiagnosisResultPage extends StatefulWidget {
  final int? id;
  final DiagnosisEntity? diagnosis;

  const DiagnosisResultPage({
    super.key,
    this.id,
    this.diagnosis,
  });

  @override
  State<DiagnosisResultPage> createState() => _DiagnosisResultPageState();
}

class _DiagnosisResultPageState extends BaseState<DiagnosisResultPage,
    DiagnosisResultEvent, DiagnosisResultState, DiagnosisResultBloc> {
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      bloc.add(DiagnosisResultEvent.getData(id: widget.id!));
    }
  }

  @override
  void listener(BuildContext context, DiagnosisResultState state) {
    super.listener(context, state);
    switch (state.status) {
      case BaseStateStatus.failed:
        DialogService.showInformationDialog(
          context,
          title: 'error'.tr(),
          description: state.message,
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'diagnosis_result'.tr(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (widget.id != null) {
            bloc.add(DiagnosisResultEvent.getData(id: widget.id!));
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blocBuilder(
                (context, state) => CachedImageWidget(
                  url: widget.diagnosis?.imageUrl ??
                      state.diagnosis?.imageUrl ??
                      '',
                  width: 1.sw,
                  height: 250.h,
                ),
                buildWhen: (previous, current) =>
                    previous.diagnosis != current.diagnosis,
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: blocBuilder(
                        (context, state) => Text(
                          widget.diagnosis?.plant ??
                              state.diagnosis?.plant ??
                              '',
                          style: AppTextStyles.s20w700,
                        ),
                        buildWhen: (previous, current) =>
                            previous.diagnosis != current.diagnosis,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    blocBuilder(
                      (context, state) => Text(
                        '${'diagnose'.tr()}: ${widget.diagnosis?.disease ?? state.diagnosis?.disease ?? ''}',
                        style: AppTextStyles.s16w600.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                      buildWhen: (previous, current) =>
                          previous.diagnosis != current.diagnosis,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "${'treatment'.tr()}:",
                      style: AppTextStyles.s16w600.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    blocBuilder(
                      (context, state) => Html(
                        data: widget.diagnosis?.treatment ??
                            state.diagnosis?.treatment ??
                            '',
                      ),
                      buildWhen: (previous, current) =>
                          previous.diagnosis != current.diagnosis,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      '${'reference'.tr()}:',
                      style: AppTextStyles.s16w600.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    blocBuilder(
                      (context, state) => InkWell(
                        onTap: () async {
                          await launchLink(widget.diagnosis?.reference ??
                              state.diagnosis?.reference ??
                              '');
                        },
                        child: Text(
                          widget.diagnosis?.reference ??
                              state.diagnosis?.reference ??
                              '',
                          style: AppTextStyles.s14w400.copyWith(
                            color: AppColors.textLink,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.textLink,
                          ),
                        ),
                      ),
                      buildWhen: (previous, current) =>
                          previous.diagnosis != current.diagnosis,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
