part of 'receiver_nav_bloc.dart';

@immutable
abstract class ReceiverNavState {}

class ReceiverInViewClientsState extends ReceiverNavState {}

class ReceiverInViewCarsState extends ReceiverNavState {}

class ReceiverInViewOrdersState extends ReceiverNavState {}
