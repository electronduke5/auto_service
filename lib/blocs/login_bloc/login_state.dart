part of 'login_bloc.dart';

class LoginState {
  final String login;

  bool get isValidLogin => login.isNotEmpty;

  final String password;

  bool get isValidPassword => password.isNotEmpty;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.login = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith(
      {String? login, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
      login: login ?? this.login,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
