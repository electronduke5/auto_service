part of 'purchasing_nav_bloc.dart';

@immutable
abstract class PurchasingNavEvent {}

class ToAddAutopartPageEvent extends PurchasingNavEvent {}

class ToViewAutopartsPageEvent extends PurchasingNavEvent {}

class ToEditAutopartsPageEvent extends PurchasingNavEvent {
  final AutopartDto autopart;
  ToEditAutopartsPageEvent({required this.autopart});
}
