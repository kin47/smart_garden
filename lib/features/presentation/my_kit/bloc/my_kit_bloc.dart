import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/index.dart';
import 'package:smart_garden/features/domain/enum/my_kit_tab.dart';

part 'my_kit_event.dart';
part 'my_kit_state.dart';
part 'my_kit_bloc.freezed.dart';
part 'my_kit_bloc.g.dart';

@injectable
class MyKitBloc extends BaseBloc<MyKitEvent, MyKitState> {
  MyKitBloc() : super(MyKitState.init()) {
    on<MyKitEvent>((event, emit) {
      event.when(
        changeTab: (tabType) => onChangeTab(tabType, emit),
      );
    });
  }

  onChangeTab(MyKitTab tabType, Emitter<MyKitState> emit) {
    if (state.currentTab != tabType) {
      emit(
        state.copyWith(
          currentTab: tabType,
        ),
      );
    }
  }
}
