import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/mqtt/mqtt_app_state.dart';
import 'package:smart_garden/common/mqtt/mqtt_manager.dart';
import 'package:smart_garden/features/presentation/my_kit/bloc/my_kit_bloc.dart';
import 'package:smart_garden/features/presentation/my_kit/widget/my_kit_tab_bar.dart';
import 'package:smart_garden/routes/app_pages.gr.dart';

@RoutePage()
class MyKitPage extends StatefulWidget {
  const MyKitPage({super.key});

  @override
  State<MyKitPage> createState() => _MyKitPageState();
}

class _MyKitPageState
    extends BaseState<MyKitPage, MyKitEvent, MyKitState, MyKitBloc> {
  late MQTTManager manager;
  late MQTTAppState currentAppState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      _configureAndConnect(currentAppState);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentAppState = Provider.of<MQTTAppState>(context);
  }

  void _configureAndConnect(MQTTAppState state) {
    // ignore: flutter_style_todos
    // TODO: Use UUID
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }
    manager = MQTTManager(
      host: dotenv.get('MQTT_HOST'),
      topic: dotenv.get('MQTT_TOPIC'),
      identifier: osPrefix,
      state: state,
    );
    manager.initializeMQTTClient();
    manager.connect();
  }

  void _disconnect() {
    manager.disconnect();
  }

  void _publishMessage(String text) {
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }
    final String message = '$osPrefix says: $text';
    manager.publish(message);
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'my_kit'.tr(),
      ),
      body: AutoTabsRouter(
        routes: const [
          KitControllerRoute(),
          KitEnvironmentRoute(),
          WeatherRoute(),
        ],
        transitionBuilder: (context, child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return BaseScaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.base200,
            isBottom: false,
            body: Column(
              children: [
                MyKitTabBar(
                  onChangeTab: (tab) {
                    bloc.add(MyKitEvent.changeTab(tab: tab));
                    tabsRouter.setActiveIndex(tab.index);
                  },
                ),
                Expanded(
                  child: child,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
