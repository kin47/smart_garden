import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/constants/location_constants.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/domain/entity/store_entity.dart';
import 'package:smart_garden/features/presentation/store/bloc/store_bloc.dart';
import 'package:smart_garden/features/presentation/store/widget/store_widget.dart';

@RoutePage()
class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState
    extends BaseState<StorePage, StoreEvent, StoreState, StoreBloc> {
  @override
  void initState() {
    super.initState();
    bloc.pagingController.addPageRequestListener((pageKey) {
      bloc.add(StoreEvent.getData(pageKey: pageKey));
    });
  }

  @override
  void listener(BuildContext context, StoreState state) {
    super.listener(context, state);
    if (state.status == BaseStateStatus.failed) {
      DialogService.showInformationDialog(
        context,
        key: const Key('store_error_dialog'),
        title: 'error'.tr(),
        description: state.message,
      );
    }
  }

  @override
  void dispose() {
    bloc.pagingController.dispose();
    super.dispose();
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          SizedBox(
            width: 1.sw,
            height: 300.h,
            child: blocBuilder(
              (context, state) => GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LocationConstants.store1,
                  zoom: 15,
                ),
                markers: state.storeList.map(
                  (store) {
                    return Marker(
                      markerId: MarkerId(store.id.toString()),
                      position: LatLng(store.latitude, store.longitude),
                      infoWindow: InfoWindow(
                        title: store.name,
                        snippet: store.address,
                      ),
                    );
                  },
                ).toSet(),
              ),
              buildWhen: (previous, current) =>
                  current.storeList != previous.storeList,
            ),
          ),
          Expanded(
            child: CustomListViewSeparated<StoreEntity>(
              controller: bloc.pagingController,
              firstPageProgressIndicator: const SizedBox.shrink(),
              builder: (context, store, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0) ...[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 16.h,
                        bottom: 8.h,
                        left: 16.w,
                      ),
                      child: Text(
                        'store_list'.tr().toUpperCase(),
                        style: AppTextStyles.s15w700.copyWith(
                          color: AppColors.deepDark,
                        ),
                      ),
                    ),
                  ],
                  StoreWidget(store: store),
                ],
              ),
              separatorBuilder: (context, index) => Container(
                height: 1.h,
                color: AppColors.gray200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
