import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/presentation/qr_scanner/bloc/qr_scanner_bloc.dart';
import 'package:smart_garden/features/presentation/qr_scanner/widget/qr_scanner_overlay.dart';

@RoutePage()
class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends BaseState<QrScannerPage, QrScannerEvent,
    QrScannerState, QrScannerBloc> {
  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: "qr_scan".tr(),
      ),
      backgroundColor: AppColors.black.withOpacity(0.6),
      body: MobileScanner(
        onDetect: (capture) {

        },
        overlay: QRScannerOverlay(
          overlayColor: AppColors.black.withOpacity(0.6),
          scannerFrameSize: 250.w,
        ),
      ),
    );
  }
}
