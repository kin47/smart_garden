import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/presentation/diagnosis/bloc/diagnosis_bloc.dart';

@RoutePage()
class DiagnosisPage extends StatefulWidget {
  const DiagnosisPage({super.key});

  @override
  State<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends BaseState<DiagnosisPage, DiagnosisEvent,
    DiagnosisState, DiagnosisBloc> {
  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: const Center(
        child: Text('Diagnosis Page'),
      ),
    );
  }
}
