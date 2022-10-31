part of 'get_employees_bloc.dart';

@immutable
abstract class GetEmployeesEvent {
  const GetEmployeesEvent();
}

class GetListEmployeesEvent extends GetEmployeesEvent {}

class NoneEvent extends GetEmployeesEvent {}

//class GetList extends GetEmployeesEvent {}
