part of 'hr_navigation_bloc.dart';

@immutable
abstract class HrNavigationState {
  final EmployeeDto? employeeEdit;

  const HrNavigationState({this.employeeEdit});
}

///Пользователь на странице просмотра всех сотрудников
class HrInViewState extends HrNavigationState {}

///Пользователь на странице доабвления сотрудника
class HrInAddState extends HrNavigationState {}

///Пользователь на странице доабвления сотрудника
class HrInEditState extends HrNavigationState {
  final EmployeeDto employee;

  const HrInEditState({required this.employee}): super(employeeEdit: employee);
}

///Пользователь на странице своего профиля
class HrInProfileState extends HrNavigationState {
  final EmployeeDto loggedEmployee;
  HrInProfileState({required this.loggedEmployee});
}
