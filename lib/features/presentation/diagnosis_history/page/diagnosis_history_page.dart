import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';
import 'package:smart_garden/features/presentation/diagnosis_history/bloc/diagnosis_history_bloc.dart';
import 'package:smart_garden/features/presentation/diagnosis_history/widget/diagnosis_item.dart';

@RoutePage()
class DiagnosisHistoryPage extends StatefulWidget {
  const DiagnosisHistoryPage({super.key});

  @override
  State<DiagnosisHistoryPage> createState() => _DiagnosisHistoryPageState();
}

class _DiagnosisHistoryPageState extends BaseState<DiagnosisHistoryPage,
    DiagnosisHistoryEvent, DiagnosisHistoryState, DiagnosisHistoryBloc> {
  @override
  void initState() {
    super.initState();
    bloc.pagingController.addPageRequestListener((pageKey) {
      bloc.add(DiagnosisHistoryEvent.getData(page: pageKey));
    });
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: CustomListViewSeparated<DiagnosisEntity>(
        controller: bloc.pagingController,
        firstPageProgressIndicator: const SizedBox.shrink(),
        builder: (context, diagnose, index) =>
            DiagnosisItem(diagnosis: diagnose),
        separatorBuilder: (context, index) => Container(
          height: 1.h,
          color: AppColors.gray200,
        ),
      ),
    );
  }
}
