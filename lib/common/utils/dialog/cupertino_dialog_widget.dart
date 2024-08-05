import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';

class CupertinoDialogWidget extends StatelessWidget {
  final String? title;
  final TextStyle? titleTextStyle;
  final String? description;
  final TextStyle? descriptionTextStyle;
  final String? leftButtonText;
  final String? rightButtonText;
  final VoidCallback? onPressedLeftButton;
  final VoidCallback? onPressedRightButton;
  final TextStyle? leftButtonTextStyle;
  final TextStyle? rightButtonTextStyle;
  final bool callBackAfterClose;
  final Widget? content;
  final VoidCallback? overrideRightButtonCallBack;
  final VoidCallback? overrideLeftButtonCallBack;

  const CupertinoDialogWidget({
    super.key,
    this.title,
    this.titleTextStyle,
    this.description,
    this.descriptionTextStyle,
    this.leftButtonText,
    this.rightButtonText,
    this.onPressedLeftButton,
    this.onPressedRightButton,
    this.leftButtonTextStyle,
    this.rightButtonTextStyle,
    this.callBackAfterClose = false,
    this.content,
    this.overrideRightButtonCallBack,
    this.overrideLeftButtonCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      key: const Key('cupertino_alert_dialog'),
      title: title != null
          ? Text(
        title!,
        style: titleTextStyle ??
            AppTextStyles.s16w600.copyWith(
              color: AppColors.black22,
            ),
      )
          : const SizedBox.shrink(),
      content: content ??
          (description != null
              ? Text(
            description!,
            textAlign: TextAlign.center,
            style: descriptionTextStyle ??
                AppTextStyles.s12w400.copyWith(
                  color: AppColors.black22,
                ),
          )
              : const SizedBox.shrink()),
      actions: [
        CupertinoDialogAction(
          key: rightButtonText != null
              ? const Key('dialog_left_button')
              : const Key('dialog_button'),
          onPressed: overrideLeftButtonCallBack ??
                  () {
                if (callBackAfterClose) {
                  Navigator.of(context).pop();
                  onPressedLeftButton?.call();
                } else {
                  onPressedLeftButton?.call();
                  Navigator.of(context).pop();
                }
              },
          child: Text(
            leftButtonText ?? 'close'.tr(),
            style: leftButtonTextStyle ??
                AppTextStyles.s16w400.copyWith(
                  color: AppColors.alertLink,
                ),
          ),
        ),
        if (rightButtonText != null)
          CupertinoDialogAction(
            key: const Key('dialog_right_button'),
            onPressed: overrideRightButtonCallBack ??
                    () {
                  Navigator.of(context).pop();
                  onPressedRightButton?.call();
                },
            child: Text(
              rightButtonText!,
              style: rightButtonTextStyle ??
                  AppTextStyles.s16w600.copyWith(
                    color: AppColors.alertLink,
                  ),
            ),
          ),
      ],
    );
  }
}
