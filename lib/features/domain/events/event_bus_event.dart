import 'package:smart_garden/features/domain/enum/core_tab.dart';

class OpenLoginPageEvent {
  const OpenLoginPageEvent();
}

class ChangeCoreTabEvent {
  final CoreTab tab;

  const ChangeCoreTabEvent(
    this.tab,
  );
}