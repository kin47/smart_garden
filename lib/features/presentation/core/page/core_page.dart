import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/domain/entity/bottom_nav_bar_item_entity.dart';
import 'package:smart_garden/features/domain/enum/core_tab.dart';
import 'package:smart_garden/features/domain/events/event_bus_event.dart';
import 'package:smart_garden/features/presentation/core/bloc/core_bloc.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class CorePage extends StatefulWidget {
  const CorePage({super.key});

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState
    extends BaseState<CorePage, CoreEvent, CoreState, CoreBloc> {
  TabsRouter? _tabsRouter;
  EventBus eventBus = getIt<EventBus>();

  @override
  void initState() {
    super.initState();
    eventBus.on<ChangeTabEvent>().listen((event) {
      if (event.tab != CoreTab.scan) {
        _tabsRouter?.setActiveIndex(event.tab.index);
        bloc.add(CoreEvent.changeTab(event.tab));
      }
    });
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      appBar: blocBuilder(
        (context, state) => BaseAppBar(
          hasBack: false,
          title: state.activeTab.title,
          actions: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Assets.svg.icon20BellOff.svg(
                    width: 20.w,
                  ),
                ),
              ),
            ),
          ],
        ),
        buildWhen: (previous, current) =>
            previous.activeTab != current.activeTab,
      ),
      body: AutoTabsRouter(
        routes: [
          ...CoreTab.values.map(
            (tab) => tab.pageRouteInfo,
          ),
        ],
        transitionBuilder: (context, child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        builder: (context, child) {
          _tabsRouter = context.tabsRouter;
          return child;
        },
      ),
      bottomNavigation: blocBuilder(
        (context, state) => CustomBottomNavigationBar(
          activeTab: state.activeTab,
          onClickBottomBar: (item) {
            eventBus.fire(ChangeTabEvent(item.type));
          },
          items: [
            ...CoreTab.values.map(
              (e) => BottomNavBarItemEntity(
                type: e,
                isSelected: e == CoreTab.home,
              ),
            ),
          ],
        ),
        buildWhen: (previous, current) =>
            previous.activeTab != current.activeTab,
      ),
      floatingActionButton: Container(
        width: 1.sw / 6,
        height: 1.sw / 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: AppColors.primary700,
        ),
        child: IconButton(
          icon: Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
            size: 1.sw / 10,
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
