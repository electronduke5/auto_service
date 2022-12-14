part of 'storekeeper_nav_bloc.dart';

@immutable
abstract class StorekeeperNavState {
  final AutopartDto? autopartEdit;

  const StorekeeperNavState({this.autopartEdit});
}

class StorekeeperInEditState extends StorekeeperNavState {
  const StorekeeperInEditState({required super.autopartEdit});
}

class StorekeeperInViewState extends StorekeeperNavState {}

class StorekeeperInViewCategoriesState extends StorekeeperNavState {}

class StorekeeperInViewServicesState extends StorekeeperNavState {}

class StorekeeperInViewTypesState extends StorekeeperNavState {}
