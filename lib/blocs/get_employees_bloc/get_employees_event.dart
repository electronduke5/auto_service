part of 'get_employees_bloc.dart';

@immutable
abstract class GetEmployeesEvent {
  const GetEmployeesEvent();
}

class GetListEmployeesEvent extends GetEmployeesEvent {}

class SortBySurname extends GetEmployeesEvent {}
class SortByRole extends GetEmployeesEvent {}
class SortBySalary extends GetEmployeesEvent {}
class SortBySalaryDesc extends GetEmployeesEvent {}

class NoneEvent extends GetEmployeesEvent {}

//class GetList extends GetEmployeesEvent {}
