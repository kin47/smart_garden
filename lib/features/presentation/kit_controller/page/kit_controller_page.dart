import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/presentation/kit_controller/bloc/kit_controller_bloc.dart';
import 'package:smart_garden/features/presentation/kit_controller/widget/round_button.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class KitControllerPage extends StatefulWidget {
  const KitControllerPage({super.key});

  @override
  State<KitControllerPage> createState() => _KitControllerPageState();
}

class _KitControllerPageState extends BaseState<KitControllerPage,
    KitControllerEvent, KitControllerState, KitControllerBloc> {
  @override
  void listener(BuildContext context, KitControllerState state) {
    super.listener(context, state);
    if (state.status == BaseStateStatus.showPopUp) {
      DialogService.showInformationDialog(
        context,
        description: state.message,
      );
    }
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              _buildLightManagement(),
              SizedBox(height: 24.h),
              _buildPumpManagement(),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLightManagement() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.h,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'light_management'.tr(),
            style: AppTextStyles.s16w600.copyWith(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 32.h),
          blocBuilder(
            (context, state) => InkWell(
              onTap: () {
                bloc.add(
                  KitControllerEvent.toggleLightManual(
                    isLightOn: !state.isLightOn,
                  ),
                );
              },
              child: AnimatedCrossFade(
                firstChild: RoundButton(
                  color: Colors.white,
                  icon: Assets.images.lightBulbOff.image(
                    width: 60.w,
                    height: 60.w,
                  ),
                ),
                secondChild: RoundButton(
                  color: AppColors.lightBulb,
                  icon: Assets.images.lightBulbOn.image(
                    width: 60.w,
                    height: 60.w,
                  ),
                ),
                crossFadeState: state.isLightOn
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ),
            buildWhen: (previous, current) =>
                previous.isLightOn != current.isLightOn,
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'manual_turn_on'.tr(),
                style: AppTextStyles.s14w400.copyWith(
                  color: Colors.black,
                ),
              ),
              blocBuilder(
                (context, state) => CupertinoSwitch(
                  value: state.isLightOn,
                  onChanged: (value) {
                    bloc.add(
                      KitControllerEvent.toggleLightManual(
                        isLightOn: value,
                      ),
                    );
                  },
                ),
                buildWhen: (previous, current) =>
                    previous.isLightOn != current.isLightOn,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'auto'.tr(),
                style: AppTextStyles.s14w400.copyWith(
                  color: Colors.black,
                ),
              ),
              blocBuilder(
                (context, state) => CupertinoSwitch(
                  value: state.autoLight,
                  onChanged: (value) {
                    bloc.add(
                      KitControllerEvent.toggleAutoLight(
                        autoLight: value,
                      ),
                    );
                  },
                ),
                buildWhen: (previous, current) =>
                    previous.autoLight != current.autoLight,
              )
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'auto_threshold'.tr(),
                style: AppTextStyles.s14w400.copyWith(
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  blocBuilder(
                    (context, state) => Text(
                      '${state.lightThreshold} lux',
                      style: AppTextStyles.s14w400.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    buildWhen: (previous, current) =>
                        previous.lightThreshold != current.lightThreshold,
                  ),
                  SizedBox(width: 8.w),
                ],
              ),
            ],
          ),
          blocBuilder(
            (context, state) => Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (state.lightThreshold > 0) {
                      bloc.add(
                        KitControllerEvent.changeLightThreshold(
                          lightThreshold: state.lightThreshold - 1,
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.remove,
                    color: AppColors.primary700,
                  ),
                ),
                Expanded(
                  child: Slider(
                    activeColor: AppColors.primary700,
                    value: state.lightThreshold.toDouble(),
                    min: 0,
                    max: 1000,
                    label: '${state.lightThreshold} lux',
                    onChanged: (value) {
                      bloc.add(
                        KitControllerEvent.changeLightThreshold(
                          lightThreshold: value.toInt(),
                        ),
                      );
                    },
                    divisions: 1000,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (state.lightThreshold < 1000) {
                      bloc.add(
                        KitControllerEvent.changeLightThreshold(
                          lightThreshold: state.lightThreshold + 1,
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    color: AppColors.primary700,
                  ),
                ),
              ],
            ),
            buildWhen: (previous, current) =>
                previous.lightThreshold != current.lightThreshold,
          ),
        ],
      ),
    );
  }

  Widget _buildPumpManagement() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.h,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'pump_management'.tr(),
            style: AppTextStyles.s16w600.copyWith(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 32.h),
          blocBuilder(
            (context, state) => InkWell(
              onTap: () {
                bloc.add(
                  KitControllerEvent.togglePumpManual(
                    isPumpOn: !state.isPumpOn,
                  ),
                );
              },
              child: AnimatedCrossFade(
                firstChild: RoundButton(
                  color: Colors.white,
                  icon: Assets.images.pumpOff.image(
                    width: 60.w,
                    height: 60.w,
                  ),
                ),
                secondChild: RoundButton(
                  color: AppColors.water,
                  icon: Assets.images.pumpOn.image(
                    width: 60.w,
                    height: 60.w,
                  ),
                ),
                crossFadeState: state.isPumpOn
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ),
            buildWhen: (previous, current) =>
                previous.isPumpOn != current.isPumpOn,
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'manual_turn_on'.tr(),
                style: AppTextStyles.s14w400.copyWith(
                  color: Colors.black,
                ),
              ),
              blocBuilder(
                (context, state) => CupertinoSwitch(
                  value: state.isPumpOn,
                  onChanged: (value) {
                    bloc.add(
                      KitControllerEvent.togglePumpManual(
                        isPumpOn: value,
                      ),
                    );
                  },
                ),
                buildWhen: (previous, current) =>
                    previous.isPumpOn != current.isPumpOn,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'auto'.tr(),
                style: AppTextStyles.s14w400.copyWith(
                  color: Colors.black,
                ),
              ),
              blocBuilder(
                (context, state) => CupertinoSwitch(
                  value: state.autoPump,
                  onChanged: (value) {
                    bloc.add(
                      KitControllerEvent.toggleAutoPump(
                        autoPump: value,
                      ),
                    );
                  },
                ),
                buildWhen: (previous, current) =>
                    previous.autoPump != current.autoPump,
              )
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'auto_threshold'.tr(),
                style: AppTextStyles.s14w400.copyWith(
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  blocBuilder(
                    (context, state) => Text(
                      '${state.pumpThreshold} %',
                      style: AppTextStyles.s14w400.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    buildWhen: (previous, current) =>
                        previous.pumpThreshold != current.pumpThreshold,
                  ),
                  SizedBox(width: 8.w),
                ],
              ),
            ],
          ),
          blocBuilder(
            (context, state) => Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (state.pumpThreshold > 0) {
                      bloc.add(
                        KitControllerEvent.changePumpThreshold(
                          pumpThreshold: state.pumpThreshold - 1,
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.remove,
                    color: AppColors.primary700,
                  ),
                ),
                Expanded(
                  child: Slider(
                    activeColor: AppColors.primary700,
                    value: state.pumpThreshold.toDouble(),
                    min: 0,
                    max: 100,
                    label: '${state.pumpThreshold} %',
                    onChanged: (value) {
                      bloc.add(
                        KitControllerEvent.changePumpThreshold(
                          pumpThreshold: value.toInt(),
                        ),
                      );
                    },
                    divisions: 100,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (state.pumpThreshold < 100) {
                      bloc.add(
                        KitControllerEvent.changePumpThreshold(
                          pumpThreshold: state.pumpThreshold + 1,
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    color: AppColors.primary700,
                  ),
                ),
              ],
            ),
            buildWhen: (previous, current) =>
                previous.pumpThreshold != current.pumpThreshold,
          ),
        ],
      ),
    );
  }
}
