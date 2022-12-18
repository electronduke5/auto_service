part of 'accountant_nav_bloc.dart';

@immutable
abstract class AccountantNavEvent {}

class ToViewAllEvent extends AccountantNavEvent {}

class ToViewProfitEvent extends AccountantNavEvent {}

class ToViewExpenseEvent extends AccountantNavEvent {}

class ToViewChartEvent extends AccountantNavEvent {}

class ToExportEvent extends AccountantNavEvent {}
