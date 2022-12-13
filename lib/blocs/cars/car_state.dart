part of 'car_bloc.dart';

class CarState {
  final String vinNumber;
  final String carNumber;
  final String model;
  final double mileage;
  final ClientDto? client;
  final FormSubmissionStatus formStatus;
  final GetModelsStatus modelsStatus;
  final String searchQuery;
  final String message;
  final DeleteStatus deleteStatus;

  bool get isClientNotEmpty => client != null;

  CarState({
    this.vinNumber = '',
    this.carNumber = '',
    this.model = '',
    this.mileage = 0.0,
    this.formStatus = const InitialFormStatus(),
    this.modelsStatus = const InitialModelsStatus(),
    this.client,
    this.searchQuery = '',
    this.message = '',
    this.deleteStatus = const InitialDeleteStatus(),
  });

  CarState copyWith({
    String? vinNumber,
    String? carNumber,
    String? model,
    double? mileage,
    FormSubmissionStatus? formStatus,
    GetModelsStatus? modelsStatus,
    ClientDto? client,
    String? searchQuery,
    String? message,
    DeleteStatus? deleteStatus,
  }) {
    return CarState(
        vinNumber: vinNumber ?? this.vinNumber,
        carNumber: carNumber ?? this.carNumber,
        model: model ?? this.model,
        mileage: mileage ?? this.mileage,
        formStatus: formStatus ?? this.formStatus,
        modelsStatus: modelsStatus ?? this.modelsStatus,
        searchQuery: searchQuery ?? this.searchQuery,
        message: message ?? this.message,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        client: client ?? this.client);
  }
}
