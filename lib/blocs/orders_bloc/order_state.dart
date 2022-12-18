part of 'order_bloc.dart';

class OrderState {
  final StatusEnum status;
  final CarDto? car;
  final ClientDto? client;
  final EmployeeDto? employee;
  final List<ServiceOrderDto>? services;
  final List<ServiceDto>? servicesAdd;
  final List<AutopartOrderDto>? autoparts;
  final List<AutopartDto>? autopartsAdd;
  final List<int>? autopartsCount;
  final GetModelsStatus modelsStatus;
  final FormSubmissionStatus formStatus;

  OrderState({
    this.status = StatusEnum.initialization,
    this.car,
    this.client,
    this.employee,
    this.services,
    this.servicesAdd,
    this.autoparts,
    this.autopartsAdd,
    this.autopartsCount,
    this.formStatus = const InitialFormStatus(),
    this.modelsStatus = const InitialModelsStatus(),
  });

  OrderState copyWith(
      {StatusEnum? status,
      CarDto? car,
      ClientDto? client,
      EmployeeDto? employee,
      List<ServiceOrderDto>? services,
      List<AutopartOrderDto>? autoparts,
      List<AutopartDto>? autopartsAdd,
      List<ServiceDto>? servicesAdd,
      List<int>? autopartsCount,
      FormSubmissionStatus? formStatus,
      GetModelsStatus? modelsStatus}) {
    return OrderState(
        status: status ?? this.status,
        car: car ?? this.car,
        client: client ?? this.client,
        employee: employee ?? this.employee,
        autoparts: autoparts ?? this.autoparts,
        autopartsAdd: autopartsAdd ?? this.autopartsAdd,
        servicesAdd: servicesAdd ?? this.servicesAdd,
        autopartsCount: autopartsCount ?? this.autopartsCount,
        services: services ?? this.services,
        formStatus: formStatus ?? this.formStatus,
        modelsStatus: modelsStatus ?? this.modelsStatus);
  }
}
