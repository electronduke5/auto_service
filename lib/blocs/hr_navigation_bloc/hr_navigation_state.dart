part of 'hr_navigation_bloc.dart';

@immutable
abstract class HrNavigationState {}

///Пользователь на странице просмотра всех сотрудников
class HrInViewState extends HrNavigationState {}

///Пользователь на странице доабвления сотрудника
class HrInAddState extends HrNavigationState {}

///Пользователь на странице своего профиля
class HrInProfileState extends HrNavigationState {
  final EmployeeDto loggedEmployee;
  HrInProfileState({required this.loggedEmployee});
}
