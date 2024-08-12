import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class DiagnosisImageInputPage extends StatelessWidget {
  const DiagnosisImageInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          Assets.svg.icPlantDiseaseDetection.svg(
            width: 1.sw,
          ),
        ],
      ),
    );
  }
}
