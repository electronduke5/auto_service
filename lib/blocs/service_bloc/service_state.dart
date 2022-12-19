part of 'service_bloc.dart';

class ServiceState {
  final String description;
  final ServiceTypeDto? type;
  final double price;
  final GetModelsStatus modelsStatus;
  final FormSubmissionStatus formStatus;
  final DeleteStatus deleteStatus;
  final String message;

  ServiceState({
    this.description = '',
    this.price = 0.0,
    this.type,
    this.modelsStatus = const InitialModelsStatus(),
    this.formStatus = const InitialFormStatus(),
    this.message = '',
    this.deleteStatus = const InitialDeleteStatus(),
  });

  ServiceState copyWith({
    String? description,
    double? price,
    ServiceTypeDto? type,
    GetModelsStatus? modelsStatus,
    String? message,
    DeleteStatus? deleteStatus,
    FormSubmissionStatus? formStatus,
  }) {
    return ServiceState(
      description: description ?? this.description,
      type: type ?? this.type,
      price: price ?? this.price,
      modelsStatus: modelsStatus ?? this.modelsStatus,
      message: message ?? this.message,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
