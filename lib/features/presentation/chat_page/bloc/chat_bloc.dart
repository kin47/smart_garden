import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/chat_message_entity.dart';
import 'package:smart_garden/features/domain/enum/sender_enum.dart';
import 'package:smart_garden/features/domain/enum/ws_action_enum.dart';
import 'package:smart_garden/features/domain/repository/chat_repository.dart';

part 'chat_event.dart';

part 'chat_state.dart';

part 'chat_bloc.freezed.dart';

part 'chat_bloc.g.dart';

@injectable
class ChatBloc extends BaseBloc<ChatEvent, ChatState>
    with BaseCommonMethodMixin {
  ChatBloc(this._chatRepository) : super(ChatState.init()) {
    on<ChatEvent>(
      (event, emit) async {
        await event.when(
          init: () => _init(emit),
          readMessage: () => _readMessage(emit),
          getChatMessages: (page) => _getChatMessages(emit, page),
          sendMessage: (message) => _sendMessage(emit, message),
          updateLastSeenMessageIndex: (index) =>
              _updateLastSeenMessageIndex(emit, index),
        );
      },
    );
  }

  final ChatRepository _chatRepository;
  late final StreamSubscription wsMessageStream;
  final TextEditingController chatTextController = TextEditingController();

  final PagingController<int, ChatMessageEntity> pagingController =
      PagingController(firstPageKey: 1);

  Future _init(Emitter<ChatState> emit) async {
    wsMessageStream = _chatRepository.wsMessageStream().listen(
      (event) async {
        switch (event.action) {
          case WSActionEnum.sendChatMessage:
            _addMessage(
              emit,
              ChatMessageEntity(
                message: event.data?.message ?? '',
                time: DateTime.now(),
                sender: event.data?.sender ?? SenderEnum.user,
                isAdminRead: false,
              ),
            );
            if (state.lastSeenMessageIndex != null) {
              add(ChatEvent.updateLastSeenMessageIndex(
                  state.lastSeenMessageIndex! + 1));
            }
            break;
          case WSActionEnum.seen:
            int index = -1;
            for (int i = 0; i < (pagingController.itemList?.length ?? 0); i++) {
              final item = pagingController.itemList![i];
              if (index == -1 && item.sender == SenderEnum.user) {
                pagingController.itemList![i] = item.copyWith(isAdminRead: true);
                index = i;
                add(ChatEvent.updateLastSeenMessageIndex(i));
                break;
              }
            }
            break;
          default:
            break;
        }
      },
    );
    add(const ChatEvent.readMessage());
  }

  Future _readMessage(Emitter<ChatState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.idle));
    final res = await _chatRepository.readMessage();
    if (res) {
      emit(
        state.copyWith(
          status: BaseStateStatus.idle,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: 'error_system'.tr(),
        ),
      );
    }
  }

  Future _getChatMessages(Emitter<ChatState> emit, int page) async {
    final res = await _chatRepository.getChatMessages(
      request: PaginationRequest(
        page: page,
        limit: 20,
      ),
    );
    pagingControllerOnLoad<ChatMessageEntity>(
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

  Future _sendMessage(Emitter<ChatState> emit, String message) async {
    emit(state.copyWith(status: BaseStateStatus.idle));
    final res = await _chatRepository.sendMessage(
      message: message,
    );
    if (res) {
      emit(
        state.copyWith(
          status: BaseStateStatus.idle,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: 'error_system'.tr(),
        ),
      );
    }
  }

  Future _updateLastSeenMessageIndex(Emitter<ChatState> emit, int index) async {
    emit(state.copyWith(lastSeenMessageIndex: index));
  }

  void _addMessage(
    Emitter<ChatState> emit,
    ChatMessageEntity message,
  ) {
    pagingControllerAddItem(pagingController, message, 0);
  }

  @override
  Future<void> close() {
    wsMessageStream.cancel();
    return super.close();
  }
}
