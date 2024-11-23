import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<QrScannerEvent>((event, emit) async {
      await event.when(
        scanQR: (qrCode) => _scanQR(emit, qrCode),
        refreshState: () async =>
            emit(state.copyWith(status: BaseStateStatus.idle)),
      );
    });
  }

  Future _scanQR(Emitter<QrScannerState> emit, String qrCode) async {
    try {
      int qrCodeInt = int.parse(qrCode);
      emit(
        state.copyWith(
          status: BaseStateStatus.success,
          kitId: qrCodeInt,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: 'qr_code_invalid'.tr(),
        ),
      );
    }
  }
}
