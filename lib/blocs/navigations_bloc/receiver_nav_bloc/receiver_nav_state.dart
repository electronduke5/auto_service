part of 'receiver_nav_bloc.dart';

@immutable
abstract class ReceiverNavState {
  final ClientDto? client;
  final CarDto? carEdit;

  const ReceiverNavState({this.client, this.carEdit});
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
