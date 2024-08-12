import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/gen/assets.gen.dart';

class BaseAppBar extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool? hasBack;
  final Widget? leading;
  final VoidCallback? onLeadingTap;
  final double? elevation;
  final double? leadingWidth;
  final Widget? appBarWidget;
  final PreferredSize? bottom;
  final List<Widget>? actions;
  final double? titleSpacing;
  final Function()? onPressedLeading;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Color? leadingColor;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final bool? backwardsCompatibility;
  final Color? textColor;
  final dynamic result;
  final Widget? leadingIcon;
  final Color? shadowColor;

  const BaseAppBar({
    Key? key,
    this.backgroundColor,
    this.titleSpacing,
    this.title,
    this.icon,
    this.leading,
    this.onLeadingTap,
    this.leadingWidth,
    this.hasBack,
    this.bottom,
    this.leadingColor,
    this.appBarWidget,
    this.textStyle,
    this.textColor,
    this.elevation,
    this.backwardsCompatibility,
    this.actions,
    this.onPressedLeading,
    this.result,
    this.systemUiOverlayStyle,
    this.leadingIcon,
    this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: elevation ?? 0.7,
      shadowColor: shadowColor,
      leadingWidth: leadingWidth,
      titleSpacing: 0,
      systemOverlayStyle: systemUiOverlayStyle ?? SystemUiOverlayStyle.dark,
      leading: leading ??
          Visibility(
            visible: hasBack ?? true,
            child: InkWell(
              onTap: onLeadingTap ??
                  () {
                    context.maybePop();
                  },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Assets.svg.icon16ArrowLeft.svg(
                  width: 16.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
      title: appBarWidget ??
          Text(
            title ?? '',
            maxLines: 1,
            style: textStyle ??
                AppTextStyles.s16w600.copyWith(color: AppColors.white),
          ),
      actions: actions ?? [SizedBox(width: 5.w)],
      bottom: bottom,
      centerTitle: true,
      flexibleSpace: Container(
        color: AppColors.primary700,
      ),
    );
  }
}
