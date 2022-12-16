part of 'service_bloc.dart';

class ServiceState {
  final GetModelsStatus modelsStatus;

  ServiceState({this.modelsStatus = const InitialModelsStatus()});

  ServiceState copyWith({GetModelsStatus? modelsStatus}) {
    return ServiceState(
      modelsStatus: modelsStatus ?? this.modelsStatus,
    );
  }
}
