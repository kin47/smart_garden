import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/common/index.dart';

@RoutePage()
class KitControllerPage extends StatefulWidget {
  const KitControllerPage({super.key});

  @override
  State<KitControllerPage> createState() => _KitControllerPageState();
}

class _KitControllerPageState extends State<KitControllerPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Text('KitControllerPage'),
      ),
    );
  }
}
