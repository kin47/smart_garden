import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/common/widgets/base_scaffold.dart';

@RoutePage()
class KitEnvironmentPage extends StatefulWidget {
  const KitEnvironmentPage({super.key});

  @override
  State<KitEnvironmentPage> createState() => _KitEnvironmentPageState();
}

class _KitEnvironmentPageState extends State<KitEnvironmentPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Text('EnvironmentPage'),
      ),
    );
  }
}
