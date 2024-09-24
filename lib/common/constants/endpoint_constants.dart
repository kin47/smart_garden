class EndpointConstants {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
  static const String resendEmailVerification = '/auth/resend';

  static const String store = '/store';

  static const String weather = '/weather';

  static const String notification = '/notification';
  static const String markAsRead = '/notification/mark-as-read/{notification_id}';
  static const String deviceToken = '/device-token';

  static const String predictDisease = '/disease_detection/predict';
  static const String predictHistory = '/disease_detection/history';

  static const List<String> publicAPI = [
    login,
    register,
    resendEmailVerification,
    weather,
  ];
}
