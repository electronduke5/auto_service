part of 'autopart_bloc.dart';

@immutable
abstract class AutopartEvent {}
//GetAutoparts
class GetListAutopartsEvent extends AutopartEvent {}

class SortByAutopartEvent extends AutopartEvent {
  final String functions = 'sort';
  final String sortByQuery;

  SortByAutopartEvent({required this.sortByQuery});
}

class SortByDescAutopartEvent extends AutopartEvent {
  final String functions = 'sortDesc';
  final String sortByDescQuery;

  SortByDescAutopartEvent({required this.sortByDescQuery});
}
//class SortByName extends AutopartEvent {}
// class SortBySalePrice extends AutopartEvent {}
// class SortByPurchasePrice extends AutopartEvent {}
//class SortByCount extends AutopartEvent {}

//class SortBySalePriceDesc extends AutopartEvent {}
//class SortByPurchasePriceDesc extends AutopartEvent {}
//class SortByCountDesc extends AutopartEvent {}

class SearchChangedEvent extends AutopartEvent {
  final String searchQuery;

  SearchChangedEvent(this.searchQuery);
}

class SearchAutopartEvent extends AutopartEvent {
  final String functions = 'search';
  final String searchQuery;

  SearchAutopartEvent({required this.searchQuery});
}

class InitialAutopartEvent extends AutopartEvent {
  final AutopartState autopartState;

  InitialAutopartEvent(this.autopartState);
}

//AddAutopart
class NameChanged extends AutopartEvent {
  final String name;

  NameChanged(this.name);
}

class PurchasePriceChanged extends AutopartEvent {
  final String purchasePrice;

  PurchasePriceChanged(this.purchasePrice);
}

class SalePriceChanged extends AutopartEvent {
  final String salePrice;

  SalePriceChanged(this.salePrice);
}

class CountChanged extends AutopartEvent {
  final String count;

  CountChanged(this.count);
}

class CategoryChanged extends AutopartEvent {
  final CategoryDto category;

  CategoryChanged(this.category);
}

class EditFormInitial extends AutopartEvent {
  final AutopartDto autopart;

  EditFormInitial({required this.autopart});
}

class FormSubmittedUpdate extends AutopartEvent{
  final int id;
  final int count;
  final AutopartDto autopart;

  FormSubmittedUpdate({required this.id, required this.count, required this.autopart});
}

class FormSubmitted extends AutopartEvent {
  final String name;
  final double purchasePrice;
  final double salePrice;
  final int count;
  final CategoryDto category;

  FormSubmitted(
      {required this.name,
      required this.purchasePrice,
      required this.salePrice,
      required this.count,
      required this.category});
}
