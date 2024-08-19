class EndpointConstants {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';

  static const String store = '/store';

  static const List<String> publicAPI = [
    login,
    register,
  ];
}
