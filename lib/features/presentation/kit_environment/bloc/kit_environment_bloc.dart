import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';

part 'kit_environment_event.dart';
part 'kit_environment_state.dart';
part 'kit_environment_bloc.freezed.dart';
part 'kit_environment_bloc.g.dart';

@injectable
class KitEnvironmentBloc extends BaseBloc<KitEnvironmentEvent, KitEnvironmentState> {
  KitEnvironmentBloc() : super(KitEnvironmentState.init()) {
    on<KitEnvironmentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
