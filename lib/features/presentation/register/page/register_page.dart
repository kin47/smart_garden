import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/common/constants/other_constants.dart';
import 'package:smart_garden/common/utils/dialog/dialog_service.dart';
import 'package:smart_garden/common/widgets/base_appbar.dart';
import 'package:smart_garden/common/widgets/base_scaffold.dart';
import 'package:smart_garden/common/widgets/buttons/app_button.dart';
import 'package:smart_garden/common/widgets/textfields/app_text_form_field.dart';
import 'package:smart_garden/features/presentation/register/bloc/register_bloc.dart';
import 'package:smart_garden/gen/assets.gen.dart';
import 'package:smart_garden/routes/app_pages.gr.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterEvent,
    RegisterState, RegisterBloc> {
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '');

  @override
  void listener(BuildContext context, RegisterState state) {
    super.listener(context, state);
    switch (state.status) {
      case BaseStateStatus.success:
        DialogService.showInformationDialog(
          context,
          title: 'register_success'.tr(),
          description: 'register_success_dialog_description'.tr(),
          onPressedButton: () {
            context.replaceRoute(const LoginRoute());
          },
        );
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
        hasBack: false,
        title: 'register'.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 14.h),
        child: ListView(
          children: [
            _buildEmail(),
            SizedBox(height: 26.h),
            _buildPassword(),
            SizedBox(height: 12.h),
            _buildCheckBox(),
            SizedBox(height: 26.h),
            _buildPhoneNumber(),
            SizedBox(height: 29.h),
            _registerButton(),
          ],
        ),
      ),
      bottomNavigation: _navigateToSignUpButton(context),
    );
  }

  Widget _navigateToSignUpButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 31.h,
        left: 16.w,
        right: 16.w,
      ),
      child: SizedBox(
        height: 55.h,
        child: AppButton(
          borderRadius: 28.r,
          onPressed: _navigateToLogin,
          textColor: AppColors.primary500,
          backgroundColor: AppColors.white,
          borderColor: AppColors.primary500,
          isOutlined: true,
          elevation: 3.h,
          shadowColor: AppColors.black.withOpacity(0.8),
          title: '',
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    'click_here_if_you_already_have_account'.tr(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.primary500,
                    ),
                  ),
                ),
                Assets.svg.icon16ArrowRight.svg(
                  width: 16.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary500,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: blocBuilder(
        (context, state) {
          return AppButton(
            borderRadius: 28.r,
            height: 56.h,
            onPressed: state.validInput ? _register : null,
            backgroundColor:
                state.validInput ? AppColors.primary500 : AppColors.grey200,
            title: 'register'.tr(),
            textStyle: AppTextStyles.s16w600,
            textColor: state.validInput
                ? AppColors.white
                : AppColors.white.withOpacity(0.6),
            shadowColor: AppColors.black.withOpacity(0.8),
            elevation: 2.h,
          );
        },
        buildWhen: (previous, current) =>
            previous.validInput != current.validInput,
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'email'.tr(),
            style: AppTextStyles.s16w600,
          ),
          SizedBox(height: 8.h),
          AppTextFormField(
            controller: _emailController,
            hintText: 'please_enter'.tr(),
            prefixIcon: SizedBox(width: 16.w),
            fillColor: AppColors.primary050,
            contentPadding: EdgeInsets.only(
              top: 16.h,
              bottom: 16.h,
              right: 16.w,
            ),
            onChanged: (value) {
              bloc.add(
                RegisterEvent.onInputEmail(
                  email: value,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: blocBuilder(
        (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'password'.tr(),
                style: AppTextStyles.s16w600,
              ),
              SizedBox(height: 8.h),
              Text(
                'register_username_description_1'.tr(),
                style: AppTextStyles.s14w400,
              ),
              SizedBox(height: 8.h),
              Text(
                'register_username_description_2'.tr(),
                style: AppTextStyles.s14w400,
              ),
              SizedBox(height: 8.h),
              AppTextFormField(
                controller: _passwordController,
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
                    RegisterEvent.onInputPassword(
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

  Widget _buildPhoneNumber() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'phone_number'.tr(),
            style: AppTextStyles.s16w600,
          ),
          SizedBox(height: 8.h),
          AppTextFormField(
            controller: _phoneNumberController,
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
                RegisterEvent.onInputPhoneNumber(
                  phoneNumber: value,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBox() {
    return GestureDetector(
      onTap: () {
        bloc.add(
          RegisterEvent.onPasswordVisibilityChanged(
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
                    key: const Key('show_password_button'),
                    onPressed: () {
                      bloc.add(
                        RegisterEvent.onPasswordVisibilityChanged(
                          isVisible: !bloc.state.isPasswordVisible,
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

  void _register() {
    bloc.add(
      const RegisterEvent.register(),
    );
  }

  void _navigateToLogin() {
    context.replaceRoute(const LoginRoute());
  }
}
