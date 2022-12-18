part of 'order_bloc.dart';

@immutable
class OrderEvent {
}

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
  final List<AutopartDto> autoparts;

  AutopartsChangedInOrderEvent(this.autoparts);
}

class AutopartsCountChangedInOrderEvent extends OrderEvent {
 List<int> count;

  AutopartsCountChangedInOrderEvent(this.count);
}

class ServicesChangedInOrderEvent extends OrderEvent {
  final List<ServiceDto> services;

  ServicesChangedInOrderEvent(this.services);
}

class OrderFormSubmittedEvent extends OrderEvent {
  final StatusEnum status;
  final CarDto car;
  final EmployeeDto employee;
  final List<AutopartDto>? autoparts;
  final List<int>? autopartsCount;
  final List<ServiceDto>? services;

  OrderFormSubmittedEvent({
    required this.status,
    required this.car,
    required this.employee,
    this.autoparts,
    this.autopartsCount,
    this.services,
  });
}

class OrderFormSubmittedUpdateEvent extends OrderEvent {
  final int id;
  final StatusEnum status;
  final CarDto car;
  final EmployeeDto employee;
  final List<AutopartDto>? autoparts;
  final List<int>? autopartsCount;
  final List<ServiceDto>? services;

  OrderFormSubmittedUpdateEvent({
    required this.id,
    required this.status,
    required this.car,
    required this.employee,
    this.autoparts,
    this.autopartsCount,
    this.services,
  });
}
