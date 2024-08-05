class EndpointConstants {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String getUserInfo = '/auth/me';
  static const String getQuestionsByQuiz =
      '/api/v1/question/get-question-by-quiz';
  static const String insertScore = '/api/v1/score/save-score';
  static const String getScoreByQuiz = '/api/v1/score/get-score-by-quiz';
  static const String getScoreByUser = '/api/v1/score/get-score-by-user';

  static const List<String> publicAPI = [
    login,
    register,
  ];
}
