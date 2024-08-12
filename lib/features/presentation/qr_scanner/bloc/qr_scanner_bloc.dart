import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';

part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';
part 'qr_scanner_bloc.freezed.dart';
part 'qr_scanner_bloc.g.dart';

@injectable
class QrScannerBloc extends BaseBloc<QrScannerEvent, QrScannerState> {
  QrScannerBloc() : super(QrScannerState.init()) {
    on<QrScannerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
