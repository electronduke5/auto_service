part of 'receiver_nav_bloc.dart';

@immutable
abstract class ReceiverNavState {
  final ClientDto? client;

  const ReceiverNavState({this.client});
}

class ReceiverInViewClientsState extends ReceiverNavState {}

class ReceiverInViewClientInfoState extends ReceiverNavState {
  const ReceiverInViewClientInfoState({required super.client});
}

class ReceiverInViewCarsState extends ReceiverNavState {}

class ReceiverInViewOrdersState extends ReceiverNavState {}
