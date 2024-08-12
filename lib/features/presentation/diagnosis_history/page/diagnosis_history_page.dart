import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/presentation/diagnosis_history/bloc/diagnosis_history_bloc.dart';

@RoutePage()
class DiagnosisHistoryPage extends StatefulWidget {
  const DiagnosisHistoryPage({super.key});

  @override
  State<DiagnosisHistoryPage> createState() => _DiagnosisHistoryPageState();
}

class _DiagnosisHistoryPageState extends BaseState<DiagnosisHistoryPage,
    DiagnosisHistoryEvent, DiagnosisHistoryState, DiagnosisHistoryBloc> {
  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: const Center(
        child: Text('Diagnosis History Page'),
      ),
    );
  }
}
