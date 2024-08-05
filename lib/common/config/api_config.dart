class ApiConfig {
  static const int limit = 20;
  static const int connectTimeout = 30; // second
  static const int receiveTimeout = 30; // second
  static const String xAuthToken = 'X-Auth-Token';
  static const String xUserId = 'X-User-Id';
  static const String authorization = 'Authorization';
  static const String accept = 'Accept';
  static const String applicationAndJson = 'Application/json';
  static const String domainCheckNetwork = 'https://www.google.com/';
  static const String keyData = 'data';
  static const String keyError = 'error';
  static const String keyAccessToken = 'access_token';
  static const String refreshTokenError = 'refresh_token_error';
  static const String resetPasswordToken = 'reset_password_token';
  static const String keyEmail = 'email';
  static const String keyTokenExpired = 'token_expired';
  static const int timeShowToast = 3; // second
  static const String renameGroupError = 'error-duplicate-channel-name';
  static const String notLoggedIn = 'not_logged_in';
}
