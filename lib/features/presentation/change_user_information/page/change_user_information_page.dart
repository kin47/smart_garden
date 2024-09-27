import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/widgets/buttons/app_button.dart';
import 'package:smart_garden/common/widgets/cache_image_widget.dart';
import 'package:smart_garden/common/widgets/textfields/app_text_form_field.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/presentation/change_user_information/bloc/change_user_information_bloc.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class ChangeUserInformationPage extends StatefulWidget {
  final UserEntity user;

  const ChangeUserInformationPage({
    super.key,
    required this.user,
  });

  @override
  State<ChangeUserInformationPage> createState() =>
      _ChangeUserInformationPageState();
}

class _ChangeUserInformationPageState extends BaseState<
    ChangeUserInformationPage,
    ChangeUserInformationEvent,
    ChangeUserInformationState,
    ChangeUserInformationBloc> {
  final ImagePicker picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.add(ChangeUserInformationEvent.init(user: widget.user));
    _nameController.text = widget.user.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  void listener(BuildContext context, ChangeUserInformationState state) {
    super.listener(context, state);
    switch (state.status) {
      case BaseStateStatus.success:
        context.router.maybePop(true);
        break;
      case BaseStateStatus.failed:
        DialogService.showInformationDialog(
          context,
          title: 'error'.tr(),
          description: state.message ?? 'error_system'.tr(),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'change_user_info'.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAvatarAndCover(),
            SizedBox(height: 8.h),
            Text(
              'change_avatar_description'.tr(),
              style: AppTextStyles.s14w400,
            ),
            SizedBox(height: 16.h),
            _buildName(),
            SizedBox(height: 16.h),
            _buildCurrentPassword(),
            SizedBox(height: 16.h),
            _buildNewPassword(),
            SizedBox(height: 8.h),
            _buildCheckBox(),
            SizedBox(height: 16.h),
            _updateUserInfoButton(),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarAndCover() {
    return Stack(
      children: [
        SizedBox(height: 300.h),
        InkWell(
          onTap: () async {
            final image = await picker.pickImage(
              source: ImageSource.gallery,
            );
            if (image != null) {
              bloc.add(
                ChangeUserInformationEvent.onChangeCoverImage(
                  coverImage: image,
                ),
              );
            }
          },
          child: blocBuilder(
            (context, state) => _buildCoverImage(state),
            buildWhen: (previous, current) =>
                previous.coverImageUrl != current.coverImageUrl ||
                previous.newCoverImage != current.newCoverImage,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () async {
                final image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  bloc.add(
                    ChangeUserInformationEvent.onChangeAvatar(
                      avatar: image,
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120.w),
                  border: Border.all(
                    color: AppColors.base100,
                    width: 5.w,
                  ),
                ),
                child: blocBuilder(
                  (context, state) => _buildAvatar(state),
                  buildWhen: (previous, current) =>
                      previous.avatarUrl != current.avatarUrl ||
                      previous.newAvatar != current.newAvatar,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCoverImage(ChangeUserInformationState state) {
    if (state.newCoverImage != null) {
      File file = File(state.newCoverImage!.path);
      return Image.file(
        file,
        width: 1.sw,
        height: 250.h,
        fit: BoxFit.cover,
      );
    }
    if (state.coverImageUrl != null && state.coverImageUrl!.isNotEmpty) {
      return CachedImageWidget(
        url: state.coverImageUrl!,
        width: 1.sw,
        height: 250.h,
      );
    }
    return Assets.images.coverImageDefault.image(
      width: 1.sw,
      height: 250.h,
      fit: BoxFit.cover,
    );
  }

  Widget _buildAvatar(ChangeUserInformationState state) {
    if (state.newAvatar != null) {
      File file = File(state.newAvatar!.path);
      return ClipOval(
        child: Image.file(
          file,
          width: 120.w,
          height: 120.w,
          fit: BoxFit.cover,
        ),
      );
    }
    if (state.avatarUrl != null && state.avatarUrl!.isNotEmpty) {
      return CachedImageWidget(
        url: state.avatarUrl!,
        width: 120.w,
        height: 120.w,
        radius: 60.w,
      );
    }
    return Assets.images.avatarDefault.image(
      width: 120.w,
      fit: BoxFit.cover,
    );
  }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'username'.tr(),
            style: AppTextStyles.s16w600,
          ),
          SizedBox(height: 8.h),
          AppTextFormField(
            controller: _nameController,
            hintText: 'please_enter'.tr(),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            prefixIcon: SizedBox(width: 16.w),
            fillColor: AppColors.primary050,
            contentPadding: EdgeInsets.only(
              top: 16.h,
              bottom: 16.h,
              right: 16.w,
            ),
            onChanged: (value) {
              bloc.add(
                ChangeUserInformationEvent.onInputName(name: value),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: blocBuilder(
        (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'current_password'.tr(),
                style: AppTextStyles.s16w600,
              ),
              SizedBox(height: 8.h),
              Text(
                'change_password_description'.tr(),
                style: AppTextStyles.s14w400,
              ),
              SizedBox(height: 8.h),
              AppTextFormField(
                controller: _currentPasswordController,
                hintText: 'please_enter'.tr(),
                obscureText: !state.isPasswordVisible,
                obscuringCharacter: '*',
                prefixIcon: SizedBox(width: 16.w),
                fillColor: AppColors.primary050,
                contentPadding: EdgeInsets.only(
                  top: 16.h,
                  bottom: 16.h,
                  right: 16.w,
                ),
                onChanged: (value) {
                  bloc.add(
                    ChangeUserInformationEvent.onInputCurrentPassword(
                      password: value,
                    ),
                  );
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegexConstants.password,
                  ),
                ],
              ),
            ],
          );
        },
        buildWhen: (previous, current) =>
            previous.isPasswordVisible != current.isPasswordVisible,
      ),
    );
  }

  Widget _buildNewPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: blocBuilder(
        (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'new_password'.tr(),
                style: AppTextStyles.s16w600,
              ),
              SizedBox(height: 8.h),
              Text(
                'register_username_description_1'.tr(),
                style: AppTextStyles.s14w400,
              ),
              SizedBox(height: 8.h),
              AppTextFormField(
                controller: _newPasswordController,
                hintText: 'please_enter'.tr(),
                obscureText: !state.isPasswordVisible,
                obscuringCharacter: '*',
                prefixIcon: SizedBox(width: 16.w),
                fillColor: AppColors.primary050,
                contentPadding: EdgeInsets.only(
                  top: 16.h,
                  bottom: 16.h,
                  right: 16.w,
                ),
                onChanged: (value) {
                  bloc.add(
                    ChangeUserInformationEvent.onInputNewPassword(
                      password: value,
                    ),
                  );
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegexConstants.password,
                  ),
                ],
              ),
            ],
          );
        },
        buildWhen: (previous, current) =>
            previous.isPasswordVisible != current.isPasswordVisible,
      ),
    );
  }

  Widget _buildCheckBox() {
    return GestureDetector(
      onTap: () {
        bloc.add(
          ChangeUserInformationEvent.onPasswordVisibilityChanged(
            isVisible: !bloc.state.isPasswordVisible,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: blocBuilder(
          (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 22.w,
                  width: 22.w,
                  child: IconButton(
                    onPressed: () {
                      bloc.add(
                        ChangeUserInformationEvent.onPasswordVisibilityChanged(
                          isVisible: !state.isPasswordVisible,
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    icon: blocBuilder(
                      buildWhen: (p, c) =>
                          p.isPasswordVisible != c.isPasswordVisible,
                      (context, state) => SvgPicture.asset(
                        state.isPasswordVisible
                            ? Assets.svg.icon16CheckOn.path
                            : Assets.svg.icon16CheckOff.path,
                        height: 16.w,
                        width: 16.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  'show_password'.tr(),
                  style: AppTextStyles.s14w400,
                ),
              ],
            );
          },
          buildWhen: (previous, current) =>
              previous.isPasswordVisible != current.isPasswordVisible,
        ),
      ),
    );
  }

  Widget _updateUserInfoButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: blocBuilder(
        (context, state) {
          return AppButton(
            borderRadius: 28.r,
            height: 56.h,
            onPressed: state.enableSaveButton ? _updateUserInfo : null,
            backgroundColor: state.enableSaveButton
                ? AppColors.primary700
                : AppColors.grey200,
            title: 'save'.tr(),
            textStyle: AppTextStyles.s16w600,
            textColor: state.enableSaveButton
                ? AppColors.white
                : AppColors.white.withOpacity(0.6),
            shadowColor: AppColors.black.withOpacity(0.8),
            elevation: 2.h,
          );
        },
        buildWhen: (previous, current) =>
            previous.enableSaveButton != current.enableSaveButton,
      ),
    );
  }

  void _updateUserInfo() {
    bloc.add(
      const ChangeUserInformationEvent.updateUserInfo(),
    );
  }
}
