class ReqresUrls {
  static const String _base = 'https://reqres.in/api';

  static const String loginUrl = '$_base/login';
  static const String createUserUrl = '$_base/users';
  static const String updateUserUrl = '$_base/users/{id}';
  static const String listUsersUrl = '$_base/users?page={n}';
  static const String singleUserUrl = '$_base/users/{id}';

  static const String testUrl = '$_base/users/2';
  static const String testPostUrl = '$_base/users';
}
