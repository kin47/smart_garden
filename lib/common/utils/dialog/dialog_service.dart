import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/common/utils/dialog/cupertino_dialog_widget.dart';
import 'package:smart_garden/common/utils/dialog/dialog_widget.dart';
import 'package:smart_garden/common/utils/dialog/loading_widget.dart';

class DialogService {
  static bool isShowLoading = false;
  static bool isShowActionDialog = false;

  static Future<dynamic> showInformationDialog(
    BuildContext context, {
    Key? key,
    String? title,
    String? description,
    TextStyle? descriptionTextStyle,
    String? buttonText,
    TextStyle? buttonTextStyle,
    VoidCallback? onPressedButton,
    bool callBackAfterClose = false,
    bool barrierDismissible = false,
    bool isOnlyDialog = false,
  }) {
    if (isShowActionDialog && isOnlyDialog) return Future.value();
    isShowActionDialog = true;
    return showDialog(
      context: context,
      builder: (context) {
        return PopScope(
          canPop: barrierDismissible,
          child: Theme.of(context).platform == TargetPlatform.iOS
              ? CupertinoDialogWidget(
                  key: key,
                  leftButtonTextStyle: buttonTextStyle ??
                      AppTextStyles.s16w600.copyWith(
                        color: AppColors.textLink,
                      ),
                  leftButtonText: buttonText ?? 'close'.tr(),
                  onPressedLeftButton: onPressedButton,
                  title: title,
                  description: description,
                  descriptionTextStyle: descriptionTextStyle,
                  callBackAfterClose: callBackAfterClose,
                )
              : DialogWidget(
                  key: key,
                  title: title,
                  description: description,
                  descriptionTextStyle: descriptionTextStyle,
                  rightButtonText: buttonText ?? 'close'.tr(),
                  rightButtonTextStyle: buttonTextStyle,
                  onPressedRightButton: onPressedButton,
                  callBackAfterClose: callBackAfterClose,
                ),
        );
      },
    );
  }

  static Future<dynamic> showActionDialog(
    BuildContext context, {
    Key? key,
    String? leftButtonText,
    String? rightButtonText,
    VoidCallback? onPressedLeftButton,
    VoidCallback? onPressedRightButton,
    String? title,
    String? description,
    TextStyle? descriptionTextStyle,
    TextStyle? leftButtonTextStyle,
    TextStyle? rightButtonTextStyle,
    bool callBackAfterClose = false,
    bool barrierDismissible = true,
    bool isOnlyDialog = false,
    Widget? content,
  }) {
    if (isShowActionDialog && isOnlyDialog) return Future.value();
    isShowActionDialog = true;
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return PopScope(
          canPop: barrierDismissible,
          child: Theme.of(context).platform == TargetPlatform.iOS
              ? CupertinoDialogWidget(
                  key: key,
                  leftButtonTextStyle: leftButtonTextStyle,
                  leftButtonText: leftButtonText,
                  onPressedLeftButton: onPressedLeftButton,
                  title: title,
                  description: description,
                  content: content,
                  descriptionTextStyle: descriptionTextStyle,
                  rightButtonText: rightButtonText ?? 'OK'.tr(),
                  onPressedRightButton: onPressedRightButton,
                  rightButtonTextStyle: rightButtonTextStyle,
                  callBackAfterClose: callBackAfterClose,
                )
              : DialogWidget(
                  key: key,
                  leftButtonTextStyle: leftButtonTextStyle,
                  leftButtonText: leftButtonText,
                  onPressedLeftButton: onPressedLeftButton,
                  description: description,
                  content: content,
                  title: title,
                  descriptionTextStyle: descriptionTextStyle,
                  rightButtonText: rightButtonText ?? 'OK'.tr(),
                  onPressedRightButton: onPressedRightButton,
                  rightButtonTextStyle: rightButtonTextStyle,
                  callBackAfterClose: callBackAfterClose,
                ),
        );
      },
    ).whenComplete(
      () => isShowActionDialog = false,
    );
  }

  static Future<dynamic> showActionDialogWithSmartDialog({
    Key? key,
    String? leftButtonText,
    String? rightButtonText,
    VoidCallback? onPressedLeftButton,
    VoidCallback? onPressedRightButton,
    String? title,
    String? description,
    TextStyle? descriptionTextStyle,
    TextStyle? leftButtonTextStyle,
    TextStyle? rightButtonTextStyle,
    bool callBackAfterClose = false,
    bool barrierDismissible = true,
    bool isOnlyDialog = false,
    Widget? content,
  }) {
    if (isShowActionDialog && isOnlyDialog) return Future.value();
    isShowActionDialog = true;
    return SmartDialog.show(
      backDismiss: barrierDismissible,
      builder: (BuildContext context) {
        return PopScope(
          canPop: barrierDismissible,
          child: Theme.of(context).platform == TargetPlatform.iOS
              ? CupertinoDialogWidget(
                  key: key,
                  leftButtonTextStyle: leftButtonTextStyle,
                  leftButtonText: leftButtonText,
                  title: title,
                  description: description,
                  content: content,
                  descriptionTextStyle: descriptionTextStyle,
                  rightButtonText: rightButtonText ?? 'OK'.tr(),
                  rightButtonTextStyle: rightButtonTextStyle,
                  overrideLeftButtonCallBack: onPressedLeftButton,
                  overrideRightButtonCallBack: onPressedRightButton,
                )
              : DialogWidget(
                  key: key,
                  leftButtonTextStyle: leftButtonTextStyle,
                  leftButtonText: leftButtonText,
                  overrideLeftButtonCallBack: onPressedLeftButton,
                  overrideRightButtonCallBack: onPressedRightButton,
                  description: description,
                  content: content,
                  title: title,
                  descriptionTextStyle: descriptionTextStyle,
                  rightButtonText: rightButtonText ?? 'OK'.tr(),
                  rightButtonTextStyle: rightButtonTextStyle,
                ),
        );
      },
    ).whenComplete(
      () => isShowActionDialog = false,
    );
  }

  static Future<dynamic> showLoading() {
    if (isShowLoading) {
      return Future.value();
    }
    isShowLoading = true;
    return SmartDialog.showLoading(
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const LoadingWidget(
            key: Key('loading_dialog_key'),
          ),
        );
      },
    );
  }

  static hideDialog(BuildContext context) {
    if (!isShowLoading) {
      return Future.value();
    }
    isShowLoading = false;
    Navigator.of(context).pop();
  }

  static hideLoading() {
    if (!isShowLoading) {
      return Future.value();
    }
    isShowLoading = false;
    SmartDialog.dismiss(status: SmartStatus.loading);
  }

  static Future<dynamic> showCustomDialog(
    BuildContext context,
    Widget dialogUi, {
    bool isOnlyDialog = false,
    bool barrierDismissible = false,
  }) {
    if (isShowActionDialog && isOnlyDialog) return Future.value();
    isShowActionDialog = true;
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return dialogUi;
      },
    ).whenComplete(
      () => isShowActionDialog = false,
    );
  }
}
