import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/utils/date_time/date_time_utils.dart';
import 'package:smart_garden/features/domain/entity/notification_entity.dart';
import 'package:smart_garden/features/presentation/notification_list/bloc/notification_list_bloc.dart';

@RoutePage()
class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends BaseState<NotificationListPage,
    NotificationListEvent, NotificationListState, NotificationListBloc> {
  @override
  void initState() {
    super.initState();
    bloc.pagingController.addPageRequestListener((pageKey) {
      bloc.add(NotificationListEvent.getNotifications(page: pageKey));
    });
  }

  @override
  void listener(BuildContext context, NotificationListState state) {
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
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'notification_list'.tr(),
      ),
      body: CustomListViewSeparated<NotificationEntity>(
        controller: bloc.pagingController,
        firstPageProgressIndicator: const SizedBox.shrink(),
        builder: (context, entity, index) => InkWell(
          onTap: () {
            bloc.add(NotificationListEvent.readNotification(
                notificationId: entity.id));
          },
          child: Container(
            color:
                entity.isRead ? AppColors.white : AppColors.unreadNotification,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entity.message,
                  style: AppTextStyles.s14w400,
                ),
                SizedBox(height: 8.h),
                Text(
                  DateTimeUtils.getStringDate(
                    entity.time,
                    Pattern.ddMMyyyyHHmm,
                  ),
                  style: AppTextStyles.s12w300.copyWith(
                    color: AppColors.gray700,
                  ),
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: 1.h,
          color: AppColors.gray500,
        ),
      ),
    );
  }
}
