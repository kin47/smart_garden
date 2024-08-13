import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final bool isDisable;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? elevation;
  final Color textColor;
  final Color? shadowColor;
  final bool? isOutlined;
  final Widget? child;
  final double childGap;

  const AppButton({
    Key? key,
    this.onPressed,
    this.textColor = AppColors.white,
    this.textStyle,
    this.trailingIcon,
    this.leadingIcon,
    this.isDisable = false,
    this.horizontalPadding,
    this.verticalPadding,
    this.backgroundColor = AppColors.primary700,
    this.borderColor,
    this.borderRadius,
    required this.title,
    this.width,
    this.isOutlined,
    this.height,
    this.shadowColor,
    this.elevation,
    this.child,
    this.childGap = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDisable ? null : onPressed,
      style: (isOutlined ?? false)
          ? OutlinedButton.styleFrom(
        foregroundColor: textColor.withOpacity(0.5),
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor ?? AppColors.deepDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
        padding: EdgeInsets.zero,
        shadowColor: shadowColor ?? AppColors.shadow,
        elevation: elevation ?? 0,
      )
          : ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          isDisable
              ? AppColors.primary300
              : backgroundColor ?? AppColors.deepDark,
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.zero,
        ),
        elevation: WidgetStateProperty.all(elevation ?? 0),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          ),
        ),
        shadowColor: WidgetStateProperty.all(shadowColor ?? AppColors.shadow),
      ),
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0,
          vertical: verticalPadding ?? 14.h,
        ),
        child: child ??
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leadingIcon ?? const SizedBox.shrink(),
                  if (leadingIcon != null)
                    SizedBox(
                      width: childGap,
                    ),
                  Flexible(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle?.copyWith(color: textColor) ??
                          AppTextStyles.button15ptMedium
                              .copyWith(color: textColor),
                    ),
                  ),
                  if (trailingIcon != null)
                    SizedBox(
                      width: childGap,
                    ),
                  trailingIcon ?? const SizedBox.shrink(),
                ],
              ),
            ),
      ),
    );
  }
}
