import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/presentation/diagnosis/bloc/diagnosis_bloc.dart';
import 'package:smart_garden/features/presentation/diagnosis/widget/diagnosis_tab_bar.dart';
import 'package:smart_garden/routes/app_pages.gr.dart';

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
    return AutoTabsRouter(
      routes: const [
        DiagnosisImageInputRoute(),
        DiagnosisHistoryRoute(),
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
              DiagnosisTabBar(
                onChangeTab: (tab) {
                  bloc.add(DiagnosisEvent.changeTab(tabType: tab));
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
    );
  }
}
