import 'package:smart_garden/features/domain/enum/core_tab.dart';

class OpenLoginPageEvent {
  const OpenLoginPageEvent();
}

class ChangeTabEvent {
  final CoreTab tab;

  const ChangeTabEvent(
    this.tab,
  );
}
