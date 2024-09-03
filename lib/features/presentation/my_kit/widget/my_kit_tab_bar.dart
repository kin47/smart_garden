import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/features/domain/enum/my_kit_tab.dart';
import 'package:smart_garden/features/presentation/my_kit/bloc/my_kit_bloc.dart';

class MyKitTabBar extends StatelessWidget {
  final Function(MyKitTab type) onChangeTab;

  const MyKitTabBar({
    super.key,
    required this.onChangeTab,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyKitBloc, MyKitState>(
      bloc: context.read<MyKitBloc>(),
      builder: (context, state) {
        return Row(
          children: MyKitTab.values
              .map(
                (e) => Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (state.currentTab != e) onChangeTab(e);
                    },
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          e.label,
                          style: AppTextStyles.s14w500.copyWith(
                            color: state.currentTab == e
                                ? AppColors.primary700
                                : AppColors.gray600,
                          ),
                        ),
                        SizedBox(height: 13.h),
                        Container(
                          height: 3.h,
                          width: 1.sw,
                          color: state.currentTab == e
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
          previous.currentTab != current.currentTab,
    );
  }
}
