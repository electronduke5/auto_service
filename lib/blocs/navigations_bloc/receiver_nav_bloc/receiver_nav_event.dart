part of 'receiver_nav_bloc.dart';

@immutable
abstract class ReceiverNavEvent {}

class ToViewClientsEvent extends ReceiverNavEvent {}

class ToViewCarsEvent extends ReceiverNavEvent {}

class ToViewOrdersEvent extends ReceiverNavEvent {}
