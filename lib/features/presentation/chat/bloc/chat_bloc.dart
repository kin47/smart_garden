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
import 'package:smart_garden/features/data/request/get_chat_messages_request/get_chat_messages_request.dart';
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
    on<ChatEvent>((event, emit) async {
      await event.when(
        init: () => _init(emit),
        readMessage: () => _readMessage(emit),
        getChatMessages: (page, lastMessageId) =>
            _getChatMessages(emit, page, lastMessageId),
        sendMessage: (message) => _sendMessage(emit, message),
        updateLastSeenMessageIndex: (index) =>
            _updateLastSeenMessageIndex(emit, index),
      );
    });
  }

  final ChatRepository _chatRepository;
  StreamSubscription? wsMessageStream;
  final TextEditingController chatTextController = TextEditingController();

  final PagingController<int, ChatMessageEntity> pagingController =
      PagingController(firstPageKey: 1);

  Future _init(Emitter<ChatState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final conversationId = await _chatRepository.createSupportConversation();
    if (conversationId == null) {
      emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: 'error_system'.tr(),
        ),
      );
      return;
    }
    _chatRepository.initializeConversation(conversationId);
    wsMessageStream = _chatRepository.wsMessageStream().listen((event) async {
      switch (event.action) {
        case WSActionEnum.sendChatMessage:
          _addMessage(
            emit,
            ChatMessageEntity(
              id: event.data?.id,
              message: event.data?.message ?? '',
              time: event.data?.createdAt ?? DateTime.now(),
              sender: event.data?.sender ?? SenderEnum.user,
              isAdminRead: false,
            ),
          );
          if (state.lastSeenMessageIndex != null) {
            add(
              ChatEvent.updateLastSeenMessageIndex(
                state.lastSeenMessageIndex! + 1,
              ),
            );
          }
          if (event.data?.sender == SenderEnum.admin &&
              event.data?.id != null) {
            add(const ChatEvent.readMessage());
          }
          break;
        case WSActionEnum.seen:
          final cursor = event.data?.lastReadMessageId;
          if (cursor == null || event.data?.readerUserId == null) {
            break;
          }
          final messages = pagingController.itemList;
          if (messages == null) break;
          final updatedMessages = messages
              .map(
                (message) =>
                    message.sender == SenderEnum.user &&
                        (message.id ?? 0) <= cursor
                    ? message.copyWith(isAdminRead: true)
                    : message,
              )
              .toList();
          pagingController.itemList = updatedMessages;
          final seenIndex = updatedMessages.indexWhere(
            (message) =>
                message.sender == SenderEnum.user && message.isAdminRead,
          );
          if (seenIndex >= 0) {
            add(ChatEvent.updateLastSeenMessageIndex(seenIndex));
          }
          break;
        default:
          break;
      }
    });
    emit(state.copyWith(status: BaseStateStatus.idle));
  }

  Future _readMessage(Emitter<ChatState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.idle));
    final messages = pagingController.itemList;
    final lastReadMessageId = messages
        ?.where(
          (message) => message.sender == SenderEnum.admin && message.id != null,
        )
        .fold<int?>(
          null,
          (latestId, message) => latestId == null || message.id! > latestId
              ? message.id
              : latestId,
        );
    final res = await _chatRepository.readMessage(
      lastReadMessageId: lastReadMessageId,
    );
    if (res) {
      emit(state.copyWith(status: BaseStateStatus.idle));
    } else {
      emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: 'error_system'.tr(),
        ),
      );
    }
  }

  Future _getChatMessages(
    Emitter<ChatState> emit,
    int page,
    int? lastMessageId,
  ) async {
    final res = await _chatRepository.getChatMessages(
      request: GetChatMessagesRequest(lastId: lastMessageId),
    );
    pagingControllerOnLoad<ChatMessageEntity>(
      page,
      pagingController,
      res,
      onError: (String message) {
        emit(state.copyWith(status: BaseStateStatus.failed, message: message));
      },
      onSuccess: (r) {
        add(const ChatEvent.readMessage());
        emit(state.copyWith(status: BaseStateStatus.idle));
      },
    );
  }

  Future _sendMessage(Emitter<ChatState> emit, String message) async {
    emit(state.copyWith(status: BaseStateStatus.idle));
    final res = await _chatRepository.sendMessage(message: message);
    if (res) {
      emit(state.copyWith(status: BaseStateStatus.idle));
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

  void _addMessage(Emitter<ChatState> emit, ChatMessageEntity message) {
    pagingControllerAddItem(pagingController, message, 0);
  }

  @override
  Future<void> close() async {
    await wsMessageStream?.cancel();
    await _chatRepository.disconnectChat();
    return super.close();
  }
}
