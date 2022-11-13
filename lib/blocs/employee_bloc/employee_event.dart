part of 'employee_bloc.dart';

abstract class EmployeeEvent {}

class SurnameChanged extends EmployeeEvent {
  final String surname;

  SurnameChanged(this.surname);
}

class NameChanged extends EmployeeEvent {
  final String name;

  NameChanged(this.name);
}

class PatronymicChanged extends EmployeeEvent {
  final String patronymic;

  PatronymicChanged(this.patronymic);
}

class LoginChanged extends EmployeeEvent {
  final String login;

  LoginChanged(this.login);
}

class PasswordChanged extends EmployeeEvent {
  final String password;

  PasswordChanged(this.password);
}

class RoleChanged extends EmployeeEvent {
  final String role;

  RoleChanged(this.role);
}

class SalaryChanged extends EmployeeEvent {
  final int salary;

  SalaryChanged(this.salary);
}

class EditFormInitial extends EmployeeEvent{
  final EmployeeDto employee;

  EditFormInitial(
      {required this.employee});
}

class FormSubmitted extends EmployeeEvent {
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

class FormSubmittedUpdate extends EmployeeEvent {
  final int id;
  final String surname;
  final String name;
  final String patronymic;
  final int salary;
  final String role;
  final String login;
  final String? password;

  FormSubmittedUpdate(
      {required this.surname,
        required this.id,
        required this.name,
        required this.patronymic,
        required this.salary,
        required this.role,
        required this.login,
        this.password});
}
