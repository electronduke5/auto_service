part of 'receiver_nav_bloc.dart';

@immutable
abstract class ReceiverNavEvent {}

class ToViewClientsEvent extends ReceiverNavEvent {}

class ToViewClientInfoEvent extends ReceiverNavEvent {
  final ClientDto client;

  ToViewClientInfoEvent(this.client);
}

class ToViewCarsEvent extends ReceiverNavEvent {}

class ToViewOrdersEvent extends ReceiverNavEvent {}

class ToAddCarEvent extends ReceiverNavEvent {}

class ToEditCarEvent extends ReceiverNavEvent {
  final CarDto car;

  ToEditCarEvent({required this.car});
}

class ToAddClientEvent extends ReceiverNavEvent {}

class ToEditClientEvent extends ReceiverNavEvent {
  final ClientDto client;

  ToEditClientEvent({required this.client});
}

class ToAddOrderEvent extends ReceiverNavEvent {}

class ToEditOrderEvent extends ReceiverNavEvent {
  final OrderDto order;

  ToEditOrderEvent({required this.order});
}
