import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/presentation/profile/bloc/profile_bloc.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState
    extends BaseState<ProfilePage, ProfileEvent, ProfileState, ProfileBloc> {
  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAvatarAndCover(),
            SizedBox(height: 20.h),
            Text(
              'Trần Quang Minh',
              style: AppTextStyles.s20w700.copyWith(
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 16.h),
            _buildUserInfo(),
            SizedBox(height: 24.h),
            _buildHelpCenter(),
            SizedBox(height: 24.h),
            _buildLogoutButton(),
            SizedBox(height: 1.sw / 11),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarAndCover() {
    return Stack(
      children: [
        SizedBox(height: 300.h),
        Assets.images.coverImageDefault.image(
          width: 1.sw,
          height: 250.h,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120.w),
                border: Border.all(
                  color: AppColors.base100,
                  width: 5.w,
                ),
              ),
              child: Assets.images.avatarDefault.image(
                width: 120.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray200,
            blurRadius: 10.w,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'user_profile'.tr(),
            style: AppTextStyles.s18w700,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 24.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Trần Quang Minh',
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 24.w,
              ),
              SizedBox(width: 8.w),
              Text(
                '098 615 3247',
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.mail,
                size: 24.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'kin472k2@gmail.com',
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Center(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'change_user_info'.tr(),
                        style: AppTextStyles.s14w600,
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.edit,
                        size: 24.w,
                        color: AppColors.primary700,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCenter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'help_center'.tr(),
            style: AppTextStyles.s18w700.copyWith(
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray200,
                  blurRadius: 10.w,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(
                      'chat_with_admin'.tr(),
                      style: AppTextStyles.s16w500.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    leading: Assets.svg.icBubbleChat.svg(
                      width: 24.w,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 24.w,
                      color: AppColors.gray400,
                    ),
                  ),
                ),
                Divider(
                  height: 1.h,
                  color: AppColors.gray200,
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(
                      'call_support'.tr(),
                      style: AppTextStyles.s16w500.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    leading: Assets.svg.icCallChat.svg(
                      width: 24.w,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 24.w,
                      color: AppColors.gray400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return InkWell(
      onTap: () {
        bloc.add(const ProfileEvent.logout());
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Text(
            'logout'.tr(),
            style: AppTextStyles.s16w700.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
