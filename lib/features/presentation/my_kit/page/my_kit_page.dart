import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
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
