import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/widgets/buttons/app_button.dart';
import 'package:smart_garden/common/widgets/textfields/app_text_form_field.dart';
import 'package:smart_garden/features/presentation/kit_connect/bloc/kit_connect_bloc.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class KitConnectPage extends StatefulWidget {
  final int kitId;

  const KitConnectPage({
    super.key,
    required this.kitId,
  });

  @override
  State<KitConnectPage> createState() => _KitConnectPageState();
}

class _KitConnectPageState extends BaseState<KitConnectPage, KitConnectEvent,
    KitConnectState, KitConnectBloc> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.add(KitConnectEvent.init(kitId: widget.kitId));
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  void listener(BuildContext context, KitConnectState state) {
    super.listener(context, state);
    switch (state.status) {
      case BaseStateStatus.failed:
        DialogService.showInformationDialog(
          context,
          title: 'error'.tr(),
          description: state.message,
          callBackAfterClose: true,
          onPressedButton: () {
            if (state.isErrorFromGetKitDetail) {
              context.router.maybePop();
            }
          },
        );
        break;
      case BaseStateStatus.success:
        context.router.popUntilRoot();
        break;
      default:
        break;
    }
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'connect_to_kit'.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 32.h),
            _buildKitWidget(),
            SizedBox(height: 16.h),
            _buildPassword(),
            SizedBox(height: 12.h),
            _buildCheckBox(),
            SizedBox(height: 16.h),
            _connectButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildKitWidget() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Assets.images.kitImage.image(
            width: 200.w,
          ),
          SizedBox(height: 16.h, width: 1.sw),
          blocBuilder(
            (context, state) => Text(
              state.kit?.name ?? "",
              style: AppTextStyles.s16w600,
            ),
            buildWhen: (previous, current) => previous.kit != current.kit,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildPassword() {
    return blocBuilder(
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
    );
  }

  Widget _buildCheckBox() {
    return GestureDetector(
      onTap: () {
        bloc.add(
          KitConnectEvent.onPasswordVisibilityChanged(
            isVisible: !bloc.state.isPasswordVisible,
          ),
        );
      },
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
                      KitConnectEvent.onPasswordVisibilityChanged(
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
    );
  }

  Widget _connectButton() {
    return AppButton(
      borderRadius: 28.r,
      height: 56.h,
      onPressed: () {
        bloc.add(
          KitConnectEvent.connect(
            password: _passwordController.text,
          ),
        );
      },
      backgroundColor: AppColors.primary700,
      title: 'connect'.tr(),
      textStyle: AppTextStyles.s16w600,
      textColor: AppColors.white,
      shadowColor: AppColors.black.withOpacity(0.8),
      elevation: 2.h,
    );
  }
}
