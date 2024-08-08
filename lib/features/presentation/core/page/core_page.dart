import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 600.h,
              color: Colors.red,
            ),
            Container(
              height: 200.h,
              color: Colors.blue,
            ),
          ],
        ),
      ),
      bottomNavigation: blocBuilder(
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
