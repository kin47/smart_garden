import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/index.dart';
import 'package:smart_garden/features/domain/enum/core_tab.dart';

part 'core_event.dart';

part 'core_state.dart';

part 'core_bloc.freezed.dart';

part 'core_bloc.g.dart';

@injectable
class CoreBloc extends BaseBloc<CoreEvent, CoreState> {
  CoreBloc() : super(CoreState.init()) {
    on<CoreEvent>((event, emit) async {
      await event.when(
        init: () => onInit(emit),
        changeTab: (tabType) => onChangeTab(tabType, emit),
      );
    });
  }

  onInit(Emitter<CoreState> emit) async {}

  onChangeTab(CoreTab tabType, Emitter<CoreState> emit) async {
    if (tabType != state.activeTab && tabType != CoreTab.scan) {
      emit(
        state.copyWith(
          activeTab: tabType,
        ),
      );
    }
  }
}
