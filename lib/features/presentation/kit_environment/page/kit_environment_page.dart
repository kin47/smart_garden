import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/common/widgets/base_scaffold.dart';
import 'package:smart_garden/features/presentation/kit_environment/bloc/kit_environment_bloc.dart';
import 'package:smart_garden/features/presentation/kit_environment/widget/humidity_widget.dart';
import 'package:smart_garden/features/presentation/kit_environment/widget/light_widget.dart';
import 'package:smart_garden/features/presentation/kit_environment/widget/soil_moisture_widget.dart';
import 'package:smart_garden/features/presentation/kit_environment/widget/temperature_widget.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class KitEnvironmentPage extends StatefulWidget {
  const KitEnvironmentPage({super.key});

  @override
  State<KitEnvironmentPage> createState() => _KitEnvironmentPageState();
}

class _KitEnvironmentPageState extends BaseState<KitEnvironmentPage,
    KitEnvironmentEvent, KitEnvironmentState, KitEnvironmentBloc> {
  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              blocBuilder(
                (context, state) => TemperatureWidget(
                  temperature: state.temperature,
                ),
                buildWhen: (previous, current) =>
                    previous.temperature != current.temperature,
              ),
              SizedBox(height: 16.h),
              blocBuilder(
                (context, state) => HumidityWidget(
                  humidity: state.humidity,
                ),
                buildWhen: (previous, current) =>
                    previous.humidity != current.humidity,
              ),
              SizedBox(height: 16.h),
              blocBuilder(
                (context, state) => LightWidget(
                  light: state.light,
                ),
                buildWhen: (previous, current) =>
                    previous.light != current.light,
              ),
              SizedBox(height: 16.h),
              blocBuilder(
                (context, state) => SoilMoistureWidget(
                  soilMoisture: state.soilMoisture,
                ),
                buildWhen: (previous, current) =>
                    previous.soilMoisture != current.soilMoisture,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
