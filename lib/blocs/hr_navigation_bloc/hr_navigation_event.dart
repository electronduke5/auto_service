part of 'hr_navigation_bloc.dart';

@immutable
abstract class HrNavigationEvent {}

class ToEmployeesPage extends HrNavigationEvent {}

class ToAddEmployeePage extends HrNavigationEvent {}

class ToEditEmployeePage extends HrNavigationEvent {
  final EmployeeDto employee;
  ToEditEmployeePage({required this.employee});
}

class ToProfilePage extends HrNavigationEvent {
  final EmployeeDto loggedEmployee;
  ToProfilePage({required this.loggedEmployee});
}
