import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';

class ChatTextField extends StatelessWidget {
  final TextEditingController controller;

  const ChatTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'chat_hint'.tr(),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primary700,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              minLines: 1,
              maxLines: 3,
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: AppColors.primary700,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
