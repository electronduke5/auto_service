part of 'storekeeper_nav_bloc.dart';

@immutable
abstract class StorekeeperNavEvent {}

class ToViewAutopartsEvent extends StorekeeperNavEvent {}

class ToEditAutopartEvent extends StorekeeperNavEvent {
  final AutopartDto autopart;

  ToEditAutopartEvent(this.autopart);
}
