part of 'receiver_nav_bloc.dart';

@immutable
abstract class ReceiverNavState {
  final ClientDto? client;
  final CarDto? carEdit;
  final ClientDto? clientEdit;

  const ReceiverNavState({this.client, this.carEdit, this.clientEdit});
}

class ReceiverInViewClientsState extends ReceiverNavState {}

class ReceiverInViewClientInfoState extends ReceiverNavState {
  const ReceiverInViewClientInfoState({required super.client});
}

class ReceiverInViewCarsState extends ReceiverNavState {}

class ReceiverInViewOrdersState extends ReceiverNavState {}

class ReceiverInAddCarState extends ReceiverNavState {}

class ReceiverInEditCarState extends ReceiverNavState {
  final CarDto car;

  const ReceiverInEditCarState({required this.car}) : super(carEdit: car);
}

class ReceiverInAddClientState extends ReceiverNavState {}

class ReceiverInEditClientState extends ReceiverNavState {
  final ClientDto client;

  const ReceiverInEditClientState({required this.client}) : super(clientEdit: client);
}
