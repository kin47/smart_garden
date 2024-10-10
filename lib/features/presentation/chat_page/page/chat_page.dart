import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/extensions/datetime_extension.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/utils/date_time/date_time_utils.dart';
import 'package:smart_garden/features/domain/entity/chat_message_entity.dart';
import 'package:smart_garden/features/domain/enum/owner_type_enum.dart';
import 'package:smart_garden/features/presentation/chat_page/bloc/chat_bloc.dart';
import 'package:smart_garden/features/presentation/chat_page/widget/admin_message_widget.dart';
import 'package:smart_garden/features/presentation/chat_page/widget/chat_text_field.dart';
import 'package:smart_garden/features/presentation/chat_page/widget/user_message_widget.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState
    extends BaseState<ChatPage, ChatEvent, ChatState, ChatBloc> {
  @override
  void initState() {
    super.initState();
    bloc.pagingController.addPageRequestListener((pageKey) {
      bloc.add(ChatEvent.getChatMessages(pageKey));
    });
  }

  @override
  void dispose() {
    super.dispose();
    bloc.chatTextController.dispose();
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'chat_with_admin'.tr(),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomListViewSeparated<ChatMessageEntity>(
              controller: bloc.pagingController,
              reverse: true,
              emptyWidget: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.chatNoHistory.image(
                      height: 0.5.sh,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'chat_no_history'.tr(),
                      style: AppTextStyles.s14w400,
                    ),
                  ],
                ),
              ),
              firstPageErrorIndicator: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.chatNoHistory.image(
                      height: 0.5.sh,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'chat_no_history'.tr(),
                      style: AppTextStyles.s14w400,
                    ),
                  ],
                ),
              ),
              builder: (context, message, index) {
                ChatMessageEntity? previousMessage =
                    getPreviousMessage(bloc.pagingController, index);
                String? firstMessageInDay;
                if (!(previousMessage?.transDate.isSameDay(message.transDate) ??
                    false)) {
                  firstMessageInDay = DateTimeUtils.getDateMessage(
                    message.transDate,
                    languageCode: context.locale.languageCode,
                  );
                }
                if (message.ownerType == OwnerTypeEnum.admin) {
                  return AdminMessageWidget(
                    message: message,
                    firstMessageInDay: firstMessageInDay,
                  );
                } else {
                  return UserMessageWidget(
                    message: message,
                    firstMessageInDay: firstMessageInDay,
                  );
                }
              },
              separatorBuilder: (context, index) => const SizedBox.shrink(),
            ),
          ),
          ChatTextField(
            controller: bloc.chatTextController,
            onSend: (message) {
              if (message?.isNotEmpty ?? false) {
                bloc.add(ChatEvent.sendMessage(message: message!));
              }
            },
          ),
        ],
      ),
    );
  }

  ChatMessageEntity? getPreviousMessage(
    PagingController controller,
    int index,
  ) {
    if ((controller.itemList?.isEmpty ?? true) ||
        index > controller.itemList!.length - 2) {
      return null;
    }
    return controller.itemList?[index + 1];
  }
}
