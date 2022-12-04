part of 'car_bloc.dart';

class CarState {
  final String vinNumber;
  final String carNumber;
  final String model;
  final double mileage;
  final FormSubmissionStatus formStatus;
  final GetModelsStatus modelsStatus;

  CarState({
    this.vinNumber = '',
    this.carNumber = '',
    this.model = '',
    this.mileage = 0.0,
    this.formStatus = const InitialFormStatus(),
    this.modelsStatus = const InitialModelsStatus(),
  });

  CarState copyWith({
    String? vinNumber,
    String? carNumber,
    String? model,
    double? mileage,
    FormSubmissionStatus? formStatus,
    GetModelsStatus? modelsStatus,
  }) {
    return CarState(
      vinNumber: vinNumber ?? this.vinNumber,
      carNumber: carNumber ?? this.carNumber,
      model: model ?? this.model,
      mileage: mileage ?? this.mileage,
      formStatus: formStatus ?? this.formStatus,
      modelsStatus: modelsStatus ?? this.modelsStatus,
    );
  }
}
