import 'package:flutter/material.dart';
import 'mqtt_app_connection_state.dart';

class MQTTAppState with ChangeNotifier {
  MQTTAppConnectionState _appConnectionState =
      MQTTAppConnectionState.disconnected;
  String _receivedText = '';
  String _historyText = '';

  void setReceivedText(String text) {
    _receivedText = text;
    _historyText = '$_historyText$_receivedText';
    notifyListeners();
  }

  void setAppConnectionState(MQTTAppConnectionState state) {
    _appConnectionState = state;
    notifyListeners();
  }

  String get getReceivedText => _receivedText;

  String get getHistoryText => _historyText;

  MQTTAppConnectionState get getAppConnectionState => _appConnectionState;
}
