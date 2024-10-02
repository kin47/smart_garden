import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
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
                if (message.ownerType == OwnerTypeEnum.admin) {
                  return AdminMessageWidget(
                    message: message,
                  );
                } else {
                  return UserMessageWidget(
                    message: message,
                  );
                }
              },
              separatorBuilder: (context, index) => const SizedBox.shrink(),
            ),
          ),
          ChatTextField(controller: bloc.chatTextController),
        ],
      ),
    );
  }
}
