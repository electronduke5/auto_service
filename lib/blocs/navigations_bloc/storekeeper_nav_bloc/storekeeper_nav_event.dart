part of 'storekeeper_nav_bloc.dart';

@immutable
abstract class StorekeeperNavEvent {}

class ToViewAutopartsEvent extends StorekeeperNavEvent {}
class ToViewCategoriesEvent extends StorekeeperNavEvent {}
class ToViewServicesEvent extends StorekeeperNavEvent {}
class ToViewTypesEvent extends StorekeeperNavEvent {}

class ToEditAutopartEvent extends StorekeeperNavEvent {
  final AutopartDto autopart;

  ToEditAutopartEvent(this.autopart);
}
