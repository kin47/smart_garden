import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/widgets/buttons/app_button.dart';
import 'package:smart_garden/common/widgets/textfields/app_text_form_field.dart';
import 'package:smart_garden/features/presentation/login/bloc/login_bloc.dart';
import 'package:smart_garden/gen/assets.gen.dart';
import 'package:smart_garden/routes/app_pages.gr.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState
    extends BaseState<LoginPage, LoginEvent, LoginState, LoginBloc> {
  final TextEditingController _accountIdController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  @override
  void listener(BuildContext context, LoginState state) {
    super.listener(context, state);
    switch (state.actionState) {
      case LoginActionState.goToHome:
        context.router.replaceAll([
          const CoreRoute(),
        ]);
        break;
      case LoginActionState.loginError:
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
        title: 'login'.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 14.h),
        child: ListView(
          children: [
            _buildUsername(),
            SizedBox(height: 26.h),
            _buildPassword(),
            SizedBox(height: 12.h),
            _buildCheckBox(),
            SizedBox(height: 29.h),
            _loginButton(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
      bottomNavigation: _signUpButton(context),
    );
  }

  Padding _signUpButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 31.h,
        left: 16.w,
        right: 16.w,
      ),
      child: SizedBox(
        height: 55.h,
        child: AppButton(
          key: const Key('sign_up_button'),
          borderRadius: 28.r,
          onPressed: _navigateToSignUp,
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
                    'click_here_for_first_time_users'.tr(),
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

  Widget _loginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: blocBuilder(
        (context, state) {
          return AppButton(
            borderRadius: 28.r,
            height: 56.h,
            onPressed:
                /// TODO: Implement login
            // state.validInput ?
            _login
                // : null
            ,
            backgroundColor:
                state.validInput ? AppColors.primary700 : AppColors.disable,
            title: 'login'.tr(),
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

  Widget _buildUsername() {
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
            controller: _accountIdController,
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
                LoginEvent.onInputUsername(
                  username: value,
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
                    LoginEvent.onInputPassword(
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
          LoginEvent.onPasswordVisibilityChanged(
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
                        LoginEvent.onPasswordVisibilityChanged(
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

  void _login() {
    /// TODO: Implement login
    // bloc.add(const LoginEvent.login());
    context.router.replaceAll([
      const CoreRoute(),
    ]);
  }

  void _navigateToSignUp() {
    context.replaceRoute(const RegisterRoute());
  }
}
