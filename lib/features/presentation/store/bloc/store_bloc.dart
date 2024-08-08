import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';

part 'store_event.dart';
part 'store_state.dart';
part 'store_bloc.freezed.dart';
part 'store_bloc.g.dart';

@injectable
class StoreBloc extends BaseBloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreState.init()) {
    on<StoreEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
