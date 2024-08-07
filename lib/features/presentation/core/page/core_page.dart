import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:smart_garden/features/domain/entity/bottom_nav_bar_item_entity.dart';
import 'package:smart_garden/features/domain/enum/core_tab.dart';
import 'package:smart_garden/features/presentation/core/bloc/core_bloc.dart';

@RoutePage()
class CorePage extends StatefulWidget {
  const CorePage({super.key});

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState
    extends BaseState<CorePage, CoreEvent, CoreState, CoreBloc> {
  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        hasBack: false,
        title: 'home'.tr(),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: blocBuilder(
              (context, state) => CustomBottomNavigationBar(
                activeTab: state.activeTab,
                onClickBottomBar: (item) {
                  bloc.add(CoreEvent.changeTab(item.type));
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
          ),
        ],
      ),
    );
  }
}
