part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class GetListOrdersEvent extends OrderEvent {}

class GetOrdersByCarEvent extends OrderEvent {
  int id;

  GetOrdersByCarEvent(this.id);
}

class CarChangedInOrderEvent extends OrderEvent {
  final CarDto car;

  CarChangedInOrderEvent(this.car);
}

class AutopartsChangedInOrderEvent extends OrderEvent {
  final List<AutopartOrderDto> autoparts;

  AutopartsChangedInOrderEvent(this.autoparts);
}

class ServicesChangedInOrderEvent extends OrderEvent {
  final List<ServiceOrderDto> services;

  ServicesChangedInOrderEvent(this.services);
}

class OrderFormSubmittedEvent extends OrderEvent {
  final String status;
  final CarDto car;
  final EmployeeDto employee;
  final List<AutopartOrderDto> autoparts;
  final List<ServiceOrderDto> services;

  OrderFormSubmittedEvent({
    required this.status,
    required this.car,
    required this.employee,
    required this.autoparts,
    required this.services,
  });
}

class OrderFormSubmittedUpdateEvent extends OrderEvent {
  final int id;

  //TODO: Переделать статус в енум
  final String status;
  final CarDto car;
  final EmployeeDto employee;
  final List<AutopartOrderDto> autoparts;
  final List<ServiceOrderDto> services;

  OrderFormSubmittedUpdateEvent({
    required this.id,
    required this.status,
    required this.car,
    required this.employee,
    required this.autoparts,
    required this.services,
  });
}
