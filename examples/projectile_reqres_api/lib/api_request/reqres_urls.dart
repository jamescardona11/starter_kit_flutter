class ReqresUrls {
  static const String _base = 'https://reqres.in/api';

  static const String loginUrl = '$_base/login';
  static const String createUserUrl = '$_base/users';
  static const String updateUserUrl = '$_base/users/{id}';
  static const String listUsersUrl = '$_base/users?page={n}';
  static const String singleUserUrl = '$_base/user/{id}';

  static const String listResourceUrl = '$_base/unknown';
  static const String singleResourceUrl = '$_base/unknown/{id}';
}
