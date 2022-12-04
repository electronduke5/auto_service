part of 'order_bloc.dart';

class OrderState {
  final String status;
  final CarDto? car;
  final ClientDto? client;
  final EmployeeDto? employee;
  final List<ServiceOrderDto>? services;
  final List<AutopartOrderDto>? autoparts;
  final GetModelsStatus modelsStatus;
  final FormSubmissionStatus formStatus;

  OrderState({
    this.status = '',
    this.car,
    this.client,
    this.employee,
    this.services,
    this.autoparts,
    this.formStatus = const InitialFormStatus(),
    this.modelsStatus = const InitialModelsStatus(),
  });

  OrderState copyWith(
      {String? status,
      CarDto? car,
      ClientDto? client,
      EmployeeDto? employee,
      List<ServiceOrderDto>? services,
      List<AutopartOrderDto>? autoparts,
      FormSubmissionStatus? formStatus,
      GetModelsStatus? modelsStatus}) {
    return OrderState(
        status: status ?? this.status,
        car: car ?? this.car,
        client: client ?? this.client,
        employee: employee ?? this.employee,
        autoparts: autoparts ?? this.autoparts,
        services: services ?? this.services,
        formStatus: formStatus ?? this.formStatus,
        modelsStatus: modelsStatus ?? this.modelsStatus);
  }
}
