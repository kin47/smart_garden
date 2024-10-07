import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/common/widgets/bubble_chat/ninepatch_image.dart';
import 'package:smart_garden/gen/assets.gen.dart';

class BubbleChatPurple extends StatelessWidget {
  final String message;

  const BubbleChatPurple({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: NinePatchImage(
        imageProvider: Assets.images.bubbleChatPurple9.provider(),
        child: Container(
          constraints: BoxConstraints(maxWidth: 180.w, minWidth: 25.w),
          child: Text(
            message,
            style: AppTextStyles.s13w400.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}