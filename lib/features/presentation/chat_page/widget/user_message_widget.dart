import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/common/utils/date_time/date_time_utils.dart';
import 'package:smart_garden/common/widgets/bubble_chat/bubble_chat_white.dart';

import '../../../domain/entity/chat_message_entity.dart';

class UserMessageWidget extends StatefulWidget {
  final ChatMessageEntity message;
  final String? firstMessageInDay;

  const UserMessageWidget({
    super.key,
    required this.message,
    this.firstMessageInDay,
  });

  @override
  State<UserMessageWidget> createState() => _UserMessageWidgetState();
}

class _UserMessageWidgetState extends State<UserMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.firstMessageInDay != null)
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(50.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 10.r,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 9.w,
              vertical: 6.h,
            ),
            child: Text(
              widget.firstMessageInDay!,
              style: AppTextStyles.s11w500,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Text(
                DateTimeUtils.getStringDate(
                  widget.message.transDate,
                  Pattern.hhmm,
                ),
                style: AppTextStyles.s9w600.copyWith(
                  color: AppColors.primary700,
                ),
              ),
            ),
            BubbleChatWhite(message: widget.message.message ?? ""),
          ],
        ),
      ],
    );
  }
}
