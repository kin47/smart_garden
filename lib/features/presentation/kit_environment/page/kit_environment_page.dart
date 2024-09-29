import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/mqtt/mqtt_app_state.dart';
import 'package:smart_garden/common/widgets/base_scaffold.dart';
import 'package:smart_garden/features/presentation/kit_environment/bloc/kit_environment_bloc.dart';
import 'package:smart_garden/features/presentation/kit_environment/widget/humidity_widget.dart';
import 'package:smart_garden/features/presentation/kit_environment/widget/light_widget.dart';
import 'package:smart_garden/features/presentation/kit_environment/widget/soil_moisture_widget.dart';
import 'package:smart_garden/features/presentation/kit_environment/widget/temperature_widget.dart';

@RoutePage()
class KitEnvironmentPage extends StatefulWidget {
  const KitEnvironmentPage({super.key});

  @override
  State<KitEnvironmentPage> createState() => _KitEnvironmentPageState();
}

class _KitEnvironmentPageState extends BaseState<KitEnvironmentPage,
    KitEnvironmentEvent, KitEnvironmentState, KitEnvironmentBloc> {
  late MQTTAppState currentAppState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentAppState = Provider.of<MQTTAppState>(context);
    listenToMQTT(currentAppState.getReceivedText);
  }

  void listenToMQTT(String jsonString) {
    print("MQTT: $jsonString");
    if (jsonString.isNotEmpty) {
      final data = json.decode(jsonString);
      bloc.add(KitEnvironmentEvent.updateData(
        temperature: data['temperature'],
        humidity: data['humidity'],
        light: data['light'],
        soilMoisture: data['soil_moisture'],
      ));
    }
  }

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
