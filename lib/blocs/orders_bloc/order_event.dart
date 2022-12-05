part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class GetListOrdersEvent extends OrderEvent {}

class GetOrdersByCarEvent extends OrderEvent {
  int id;
  GetOrdersByCarEvent(this.id);
}
