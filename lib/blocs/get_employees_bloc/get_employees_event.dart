part of 'get_employees_bloc.dart';

@immutable
abstract class GetEmployeesEvent {}

class GetListEmployeesEvent extends GetEmployeesEvent {}

class SortBySurname extends GetEmployeesEvent {}

class SortByRole extends GetEmployeesEvent {}

class SortBySalary extends GetEmployeesEvent {}

class SortBySalaryDesc extends GetEmployeesEvent {}

class SearchChangedEvent extends GetEmployeesEvent {
  final String query;

  SearchChangedEvent(this.query);
}

class SearchEmployeeEvent extends GetEmployeesEvent {
  final String query;

  SearchEmployeeEvent(this.query);
}

class RoleFilterEvent extends GetEmployeesEvent {
  final String role;

  RoleFilterEvent(this.role);
}

class NoneEvent extends GetEmployeesEvent {}

//class GetList extends GetEmployeesEvent {}
