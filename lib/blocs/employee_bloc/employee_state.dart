part of 'employee_bloc.dart';

class EmployeeState {
  final String surname;
  final String name;
  final String patronymic;
  final int salary;
  final String role;
  final String login;
  final String password;
  final FormSubmissionStatus formStatus;

  bool get isValidSurname => surname.isNotEmpty;

  bool get isValidName => name.isNotEmpty;

  bool get isValidRole => role.isNotEmpty;

  bool isValidLogin(String? currentLogin) {
    return login.isNotEmpty ? login == currentLogin : false;
  }

  bool get isValidAddLogin => login.isNotEmpty;

  bool get isValidLoginLength => login.length > 2;

  bool get isValidPassword => password.isNotEmpty;

  bool get isValidPasswordLength => password.length > 7;
  final RegExp _regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  bool get isValidPasswordRegex => _regexPassword.hasMatch(password);

  EmployeeState({
    this.surname = '',
    this.name = '',
    this.patronymic = '',
    this.salary = 0,
    this.role = '',
    this.login = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  EmployeeState copyWith({
    String? login,
    String? password,
    String? surname,
    String? name,
    String? patronymic,
    String? role,
    int? salary,
    FormSubmissionStatus? formStatus,
  }) {
    return EmployeeState(
      surname: surname ?? this.surname,
      name: name ?? this.name,
      patronymic: patronymic ?? this.patronymic,
      role: role ?? this.role,
      login: login ?? this.login,
      password: password ?? this.password,
      salary: salary ?? this.salary,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
