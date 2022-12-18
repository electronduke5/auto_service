part of 'accountant_nav_bloc.dart';

@immutable
abstract class AccountantNavState {}

class AccountantInViewAllState extends AccountantNavState {}

class AccountantInViewProfitState extends AccountantNavState {}

class AccountantInViewExpenseState extends AccountantNavState {}

class AccountantInViewChartState extends AccountantNavState {}

class AccountantInExportState extends AccountantNavState {}


