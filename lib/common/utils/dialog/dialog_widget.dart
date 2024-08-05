import 'package:flutter/material.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';

class DialogWidget extends StatefulWidget {
  final String? leftButtonText;
  final String? rightButtonText;
  final VoidCallback? onPressedLeftButton;
  final VoidCallback? onPressedRightButton;
  final VoidCallback? overrideRightButtonCallBack;
  final VoidCallback? overrideLeftButtonCallBack;
  final String? title;
  final TextStyle? titleTextStyle;
  final String? description;
  final TextStyle? descriptionTextStyle;
  final TextStyle? leftButtonTextStyle;
  final TextStyle? rightButtonTextStyle;
  final bool callBackAfterClose;
  final Widget? content;

  const DialogWidget({
    Key? key,
    this.leftButtonText,
    this.rightButtonText,
    this.overrideRightButtonCallBack,
    this.overrideLeftButtonCallBack,
    this.onPressedLeftButton,
    this.onPressedRightButton,
    this.title,
    this.titleTextStyle,
    this.description,
    this.descriptionTextStyle,
    this.leftButtonTextStyle,
    this.rightButtonTextStyle,
    this.callBackAfterClose = false,
    this.content,
  }) : super(key: key);

  @override
  DialogWidgetState createState() => DialogWidgetState();
}

class DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: const Key('material_alert_dialog'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      title: widget.title != null
          ? Text(
              widget.title ?? "",
              style: widget.titleTextStyle ?? AppTextStyles.s16w600,
              textAlign: TextAlign.left,
            )
          : const SizedBox.shrink(),
      content: widget.content ??
          (widget.description != null
              ? Text(
                  widget.description ?? "",
                  textAlign: TextAlign.left,
                  style: widget.descriptionTextStyle ??
                      AppTextStyles.s14w400.copyWith(
                        color: AppColors.black22,
                      ),
                )
              : const SizedBox.shrink()),
      actions: [
        widget.leftButtonText != null
            ? TextButton(
                key: widget.rightButtonText != null
                    ? const Key("dialog_left_button")
                    : null,
                onPressed: widget.overrideLeftButtonCallBack ??
                    () {
                      if (widget.callBackAfterClose) {
                        Navigator.of(context).pop();
                        widget.onPressedLeftButton?.call();
                      } else {
                        widget.onPressedLeftButton?.call();
                        Navigator.of(context).pop();
                      }
                    },
                child: Text(
                  widget.leftButtonText ?? "",
                  style: widget.leftButtonTextStyle ??
                      AppTextStyles.s16w400.copyWith(
                        color: AppColors.textLink,
                      ),
                ),
              )
            : const SizedBox.shrink(),
        widget.rightButtonText != null
            ? TextButton(
                key: widget.leftButtonText != null
                    ? const Key("dialog_right_button")
                    : const Key("dialog_button"),
                onPressed: widget.overrideRightButtonCallBack ??
                    () {
                      if (widget.callBackAfterClose) {
                        Navigator.of(context).pop();
                        widget.onPressedRightButton?.call();
                      } else {
                        widget.onPressedRightButton?.call();
                        Navigator.of(context).pop();
                      }
                    },
                child: Text(
                  widget.rightButtonText ?? "",
                  style: widget.rightButtonTextStyle ??
                      AppTextStyles.s16w600.copyWith(
                        color: AppColors.textLink,
                      ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
