import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/presentation/store/bloc/store_bloc.dart';

@RoutePage()
class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState
    extends BaseState<StorePage, StoreEvent, StoreState, StoreBloc> {
  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: const Center(
        child: Text('Store Page'),
      ),
    );
  }
}
