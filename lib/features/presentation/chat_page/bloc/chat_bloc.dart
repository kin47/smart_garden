import 'package:copy_with_extension/copy_with_extension.dart';
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
          getChatMessages: (page) => _getChatMessages(emit, page),
          sendMessage: (message) => _sendMessage(emit, message),
        );
      },
    );
  }

  final ChatRepository _chatRepository;

  final TextEditingController chatTextController = TextEditingController();

  final PagingController<int, ChatMessageEntity> pagingController =
      PagingController(firstPageKey: 1);

  Future _getChatMessages(Emitter<ChatState> emit, int page) async {
    final res = await _chatRepository.getChatMessages(
      request: PaginationRequest(
        page: page,
        limit: ApiConfig.limit,
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

  }
}
