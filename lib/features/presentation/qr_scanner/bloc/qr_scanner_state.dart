part of 'qr_scanner_bloc.dart';

@CopyWith()
class QrScannerState extends BaseBlocState {
  final int? kitId;

  const QrScannerState({
    required super.status,
    super.message,
    this.kitId,
  });

  factory QrScannerState.init() => const QrScannerState(
        status: BaseStateStatus.init,
      );

  @override
  List get props => [
    status,
    message,
    kitId,
  ];
}
