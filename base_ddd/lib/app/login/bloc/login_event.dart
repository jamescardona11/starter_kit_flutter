part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginEmailOnChange extends LoginEvent {}

class LoginPasswordOnChange extends LoginEvent {}
