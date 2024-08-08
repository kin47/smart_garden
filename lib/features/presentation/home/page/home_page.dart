import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/presentation/home/bloc/home_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState
    extends BaseState<HomePage, HomeEvent, HomeState, HomeBloc> {
  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
