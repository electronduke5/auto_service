part of 'purchasing_nav_bloc.dart';

@immutable
abstract class PurchasingNavState {
  final AutopartDto? autopartEdit;

  const PurchasingNavState({this.autopartEdit});
}

class PurchasingInAddState extends PurchasingNavState {}

class PurchasingInEditState extends PurchasingNavState {
  final AutopartDto autopart;

  const PurchasingInEditState({required this.autopart}) : super(autopartEdit: autopart);
}

class PurchasingInViewState extends PurchasingNavState {}