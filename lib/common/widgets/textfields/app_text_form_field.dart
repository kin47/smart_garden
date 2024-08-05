import 'package:flutter/material.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';

class _Constant {
  static const Color alertError = Color(0xFFFE5050);
}

class AppTextFormField extends TextFormField {
  AppTextFormField({
    super.key,
    super.autocorrect,
    super.autofillHints,
    super.autofocus = false,
    super.autovalidateMode = AutovalidateMode.onUserInteraction,
    super.buildCounter,
    super.contextMenuBuilder,
    super.controller,
    super.cursorColor = Colors.black,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorWidth,
    super.enabled,
    super.enableIMEPersonalizedLearning,
    super.enableInteractiveSelection,
    super.enableSuggestions,
    super.expands,
    super.focusNode,
    super.initialValue,
    super.inputFormatters,
    super.keyboardAppearance,
    super.keyboardType,
    super.maxLength,
    super.maxLengthEnforcement,
    super.maxLines = 1,
    super.minLines,
    super.mouseCursor,
    super.obscureText = false,
    super.obscuringCharacter = '●',
    super.onChanged,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onSaved,
    super.onTap,
    super.onTapOutside,
    super.readOnly = false,
    super.restorationId,
    super.scrollController,
    super.scrollPadding = EdgeInsets.zero,
    super.scrollPhysics,
    super.selectionControls,
    super.showCursor,
    super.smartDashesType,
    super.smartQuotesType,
    super.strutStyle,
    super.style,
    super.textAlign,
    super.textAlignVertical,
    super.textCapitalization,
    super.textDirection,
    super.textInputAction,
    super.toolbarOptions,
    super.validator,
    double radius = 8,
    Color borderColor = AppColors.stroke,
    Color focusBorderColor = AppColors.deepDark,
    Color errorBorderColor = _Constant.alertError,
    Color disableColor = AppColors.backgroundGrey3,
    Color? fillColor,
    String? hintText,
    TextStyle? hintStyle,
    Widget? leadingIcon,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Function()? onTapSuffixIcon,
    EdgeInsetsGeometry? contentPadding,
    InputBorder? disabledBorder,
  }) : super(
          decoration: InputDecoration(
            contentPadding: contentPadding,
            counterText: '',
            fillColor: fillColor,
            filled: fillColor != null,
            errorMaxLines: 3,
            errorStyle: const TextStyle(
              color: AppColors.danger,
              fontSize: 12,
            ),
            prefix:
                prefixIcon != null ? UnconstrainedBox(child: prefixIcon) : null,
            prefixIcon: leadingIcon != null
                ? UnconstrainedBox(child: leadingIcon)
                : null,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onTapSuffixIcon,
                    child: suffixIcon,
                  )
                : null,
            hintText: hintText,
            hintStyle: hintStyle ??
                AppTextStyles.s16w400.copyWith(
                  color: AppColors.primary700.withOpacity(0.6),
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                color: focusBorderColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                color: errorBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            disabledBorder: disabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(
                    color: disableColor,
                  ),
                ),
          ),
        );
}
