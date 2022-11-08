part of 'add_employee_bloc.dart';

abstract class AddEmployeeEvent {}

class SurnameChanged extends AddEmployeeEvent {
  final String surname;

  SurnameChanged(this.surname);
}

class NameChanged extends AddEmployeeEvent {
  final String name;

  NameChanged(this.name);
}

class PatronymicChanged extends AddEmployeeEvent {
  final String patronymic;

  PatronymicChanged(this.patronymic);
}

class LoginChanged extends AddEmployeeEvent {
  final String login;

  LoginChanged(this.login);
}

class PasswordChanged extends AddEmployeeEvent {
  final String password;

  PasswordChanged(this.password);
}

class RoleChanged extends AddEmployeeEvent {
  final String role;

  RoleChanged(this.role);
}

class SalaryChanged extends AddEmployeeEvent {
  final int salary;

  SalaryChanged(this.salary);
}

class FormSubmitted extends AddEmployeeEvent {
  final String surname;
  final String name;
  final String patronymic;
  final int salary;
  final String role;
  final String login;
  final String password;

  FormSubmitted(
      {required this.surname,
      required this.name,
      required this.patronymic,
      required this.salary,
      required this.role,
      required this.login,
      required this.password});
}
