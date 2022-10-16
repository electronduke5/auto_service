part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginChanged extends LoginEvent {
  final String login;

  LoginChanged(this.login);
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {
  final String login;
  final String password;

  LoginSubmitted(this.login, this.password);
}
