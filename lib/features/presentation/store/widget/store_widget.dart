import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/features/domain/entity/store_entity.dart';
import 'package:smart_garden/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreWidget extends StatelessWidget {
  final StoreEntity store;

  const StoreWidget({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            store.name,
            style: AppTextStyles.s15w700,
          ),
          SizedBox(height: 8.h),
          Text(
            store.address,
            style: AppTextStyles.s14w400.copyWith(
              color: AppColors.gray600,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              InkWell(
                onTap: () async {
                  await launchUrl(
                    Uri.parse(
                      'https://www.google.com/maps/dir/?api=1&destination=${store.latitude},${store.longitude}',
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.base300,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.svg.icSignPost.svg(width: 16.w),
                      SizedBox(width: 4.w),
                      Text(
                        'show_direction'.tr(),
                        style: AppTextStyles.s14w400.copyWith(
                          color: AppColors.alertLink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              InkWell(
                onTap: () async {
                  await launchUrl(Uri.parse('tel:${store.phoneNumber}'));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.base300,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.svg.icPhone.svg(
                        width: 16.w,
                        colorFilter: const ColorFilter.mode(
                          AppColors.alertLink,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'call_phone'.tr(),
                        style: AppTextStyles.s14w400.copyWith(
                          color: AppColors.alertLink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
