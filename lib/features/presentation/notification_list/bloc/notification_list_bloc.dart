import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/common/config/api_config.dart';
import 'package:smart_garden/common/mixins/paging_mixin.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/notification_entity.dart';
import 'package:smart_garden/features/domain/repository/notification_repository.dart';

part 'notification_list_event.dart';

part 'notification_list_state.dart';

part 'notification_list_bloc.freezed.dart';

part 'notification_list_bloc.g.dart';

@injectable
class NotificationListBloc
    extends BaseBloc<NotificationListEvent, NotificationListState>
    with BaseCommonMethodMixin {
  NotificationListBloc(this._notificationRepository)
      : super(NotificationListState.init()) {
    on<NotificationListEvent>((event, emit) async {
      await event.when(
        getNotifications: (page) => _getData(emit, page),
        readNotification: (id) => _readNotification(emit, id),
      );
    });
  }

  final NotificationRepository _notificationRepository;

  PagingController<int, NotificationEntity> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _getData(Emitter<NotificationListState> emit, int page) async {
    if (page == 1) {
      emit(state.copyWith(status: BaseStateStatus.loading));
    }
    final res = await _notificationRepository.getData(
      request: PaginationRequest(
        page: page,
        limit: ApiConfig.limit,
      ),
    );
    pagingControllerOnLoad<NotificationEntity>(
      page,
      pagingController,
      res,
      onError: (String message) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failed,
            message: message,
          ),
        );
      },
      onSuccess: (r) {
        emit(
          state.copyWith(
            status: BaseStateStatus.idle,
          ),
        );
      },
    );
  }

  Future<void> _readNotification(
      Emitter<NotificationListState> emit, int id) async {
    final res = await _notificationRepository.markAsRead(id: id);
    pagingControllerUpdateItem<NotificationEntity>(
      pagingController,
      pagingController.itemList!.indexWhere((element) => element.id == id),
      pagingController.itemList!.firstWhere((element) => element.id == id)
          .copyWith(isRead: true),
    );
    res.fold(
      (l) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failed,
            message: l.getError,
          ),
        );
        pagingControllerUpdateItem<NotificationEntity>(
          pagingController,
          pagingController.itemList!.indexWhere((element) => element.id == id),
          pagingController.itemList!.firstWhere((element) => element.id == id)
              .copyWith(isRead: false),
        );
      },
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
        ),
      ),
    );
  }
}
