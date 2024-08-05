import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/common/widgets/buttons/app_button.dart';
import 'package:smart_garden/gen/assets.gen.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onTap;

  const GoogleSignInButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      borderRadius: 28.r,
      height: 56.h,
      onPressed: onTap,
      backgroundColor: AppColors.white,
      leadingIcon: Assets.svg.icGoogle.svg(
        height: 40.h,
      ),
      title: 'continue_with_google'.tr(),
      textStyle: AppTextStyles.s16w600,
      textColor: AppColors.primary700,
      shadowColor: AppColors.black.withOpacity(0.8),
      elevation: 2.h,
    );
  }
}
