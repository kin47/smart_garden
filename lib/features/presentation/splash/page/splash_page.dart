import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/presentation/splash/bloc/splash_bloc.dart';
import 'package:smart_garden/gen/assets.gen.dart';
import 'package:smart_garden/routes/app_pages.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState
    extends BaseState<SplashPage, SplashEvent, SplashState, SplashBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const SplashEvent.init());
  }

  @override
  void listener(BuildContext context, SplashState state) {
    super.listener(context, state);
    switch (state.actionState) {
      case SplashActionState.goToLogin:
        context.router.replaceAll([
          const LoginRoute(),
        ]);
        break;
      case SplashActionState.goToHome:
        context.router.replaceAll([
          const CoreRoute(),
        ]);
        break;
      default:
        break;
    }
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.splashBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Assets.images.logo.image(
              width: 0.7.sw,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            'slogan'.tr(),
            style: AppTextStyles.s16w600.copyWith(
              color: AppColors.splashText,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 70.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Made in',
                style: AppTextStyles.s12w400.copyWith(
                  color: AppColors.splashText2,
                ),
              ),
              SizedBox(width: 4.w),
              Assets.images.ptit.image(
                height: 40.h,
              ),
            ],
          ),
          SizedBox(height: 40.h),
          Text(
            'Product by: Minh Tran',
            style: AppTextStyles.s12w400.copyWith(
              color: AppColors.splashText2,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Est 09/2024',
            style: AppTextStyles.s12w400.copyWith(
              color: AppColors.splashText2,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'ver 1.0.0',
            style: AppTextStyles.s12w400.copyWith(
              color: AppColors.splashText2,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
