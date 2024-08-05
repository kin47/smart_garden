import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/widgets/buttons/app_button.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/domain/events/event_bus_event.dart';
import 'package:smart_garden/features/presentation/home_admin/bloc/home_admin_bloc.dart';
import 'package:smart_garden/gen/assets.gen.dart';

import 'package:smart_garden/routes/app_pages.gr.dart';

@RoutePage()
class HomeAdminPage extends StatefulWidget {
  final UserEntity user;

  const HomeAdminPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends BaseState<HomeAdminPage, HomeAdminEvent,
    HomeAdminState, HomeAdminBloc> {
  late StreamSubscription _eventBusSubscription;

  @override
  void initState() {
    super.initState();
    bloc.add(HomeAdminEvent.init(userEntity: widget.user));
    _eventBusSubscription =
        getIt<EventBus>().on<OpenLoginPageEvent>().listen((event) {
      context.router.replaceAll([
        const LoginRoute(),
      ]);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _eventBusSubscription.cancel();
  }

  @override
  void listener(BuildContext context, HomeAdminState state) {
    super.listener(context, state);
    switch (state.status) {
      case BaseStateStatus.logout:
        context.router.replaceAll([
          const LoginRoute(),
        ]);
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
        title: 'home'.tr(),
        hasBack: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              Row(
                children: [
                  Text(
                    'email'.tr(),
                    style: AppTextStyles.s16w400,
                  ),
                  SizedBox(width: 16.w),
                  blocBuilder(
                    buildWhen: (previous, current) =>
                        previous.userEntity != current.userEntity,
                    (context, state) => Text(
                      state.userEntity?.email ?? '',
                      style: AppTextStyles.s16w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    'role'.tr(),
                    style: AppTextStyles.s16w400,
                  ),
                  SizedBox(width: 16.w),
                  blocBuilder(
                    buildWhen: (previous, current) =>
                        previous.userEntity != current.userEntity,
                    (context, state) => Text(
                      state.userEntity?.role.value ?? '',
                      style: AppTextStyles.s16w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _buildLocateCaneButton(),
              SizedBox(height: 24.h),
              _buildMap(),
              SizedBox(height: 24.h),
              AppButton(
                title: 'logout'.tr(),
                backgroundColor: AppColors.red,
                height: 56.h,
                borderRadius: 28.r,
                onPressed: () {
                  bloc.add(const HomeAdminEvent.signOut());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return SizedBox(
      width: 1.sw,
      height: 500.h,
      child: blocBuilder(
        buildWhen: (previous, current) =>
            previous.blindPersonLocation != current.blindPersonLocation ||
            previous.myLocation != current.myLocation,
        (context, state) => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: state.blindPersonLocation,
            zoom: 14,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('myLocation'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue,
              ),
              position: state.myLocation,
              onTap: () async {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  state.myLocation.latitude,
                  state.myLocation.longitude,
                );
                String location =
                    '${placemarks.first.street}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}';
                if (context.mounted) {
                  DialogService.showInformationDialog(
                    context,
                    title: 'my_location'.tr(),
                    description: location,
                  );
                }
              },
            ),
            Marker(
              markerId: const MarkerId('blindPersonLocation'),
              position: state.blindPersonLocation,
              onTap: () async {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  state.blindPersonLocation.latitude,
                  state.blindPersonLocation.longitude,
                );
                String location =
                    '${placemarks.first.street}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}';
                if (context.mounted) {
                  DialogService.showInformationDialog(
                    context,
                    title: 'cane_location'.tr(),
                    description: location,
                  );
                }
              },
            ),
          },
        ),
      ),
    );
  }

  Widget _buildLocateCaneButton() {
    return AppButton(
      title: '',
      backgroundColor: AppColors.white,
      height: 56.h,
      borderRadius: 28.r,
      elevation: 2,
      trailingIcon: Assets.svg.icGoogleMap.svg(
        width: 24.w,
      ),
      textColor: AppColors.black,
      onPressed: () {
        bloc.add(const HomeAdminEvent.getBlindPersonLocation());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                'locate_cane'.tr(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s16w600.copyWith(
                  color: AppColors.primary500,
                ),
              ),
            ),
            Assets.svg.icGoogleMap.svg(
              width: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}
