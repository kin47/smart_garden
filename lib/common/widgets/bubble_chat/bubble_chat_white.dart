import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/common/widgets/bubble_chat/ninepatch_image.dart';
import 'package:smart_garden/gen/assets.gen.dart';

class BubbleChatWhite extends StatelessWidget {
  final String message;

  const BubbleChatWhite({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: NinePatchImage(
        hideLines: true,
        imageProvider: Assets.images.bubbleChatWhite9.provider(),
        child: Container(
          constraints: BoxConstraints(maxWidth: 180.w, minWidth: 25.w),
          child: Text(
            message,
            style: AppTextStyles.s13w400.copyWith(
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}