import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/presentation/profile/bloc/profile_bloc.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState
    extends BaseState<ProfilePage, ProfileEvent, ProfileState, ProfileBloc> {
  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: const Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
