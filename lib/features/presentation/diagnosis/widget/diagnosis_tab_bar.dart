import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/features/domain/enum/diagnosis_tab.dart';
import 'package:smart_garden/features/presentation/diagnosis/bloc/diagnosis_bloc.dart';

class DiagnosisTabBar extends StatelessWidget {
  final Function(DiagnosisTab type) onChangeTab;

  const DiagnosisTabBar({
    super.key,
    required this.onChangeTab,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosisBloc, DiagnosisState>(
      bloc: context.read<DiagnosisBloc>(),
      builder: (context, state) {
        return Row(
          children: DiagnosisTab.values
              .map(
                (e) => Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (state.activeTab != e) onChangeTab(e);
                    },
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          e.label,
                          style: AppTextStyles.s14w500.copyWith(
                            color: state.activeTab == e
                                ? AppColors.primary700
                                : AppColors.gray600,
                          ),
                        ),
                        SizedBox(height: 13.h),
                        Container(
                          height: 3.h,
                          width: 1.sw,
                          color: state.activeTab == e
                              ? AppColors.primary700
                              : AppColors.gray300,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
      buildWhen: (previous, current) =>
          previous.activeTab != current.activeTab,
    );
  }
}
