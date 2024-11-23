part of 'qr_scanner_bloc.dart';

@freezed
class QrScannerEvent with _$QrScannerEvent {
  const factory QrScannerEvent.scanQR({
    required String qrCode,
  }) = _ScanQR;

  const factory QrScannerEvent.refreshState() = _RefreshState;
}
