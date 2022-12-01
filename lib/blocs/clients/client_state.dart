part of 'client_bloc.dart';

class ClientState {
  final String surname;
  final String name;
  final String patronymic;
  final String phoneNumber;
  final FormSubmissionStatus formStatus;
  final GetModelsStatus modelsStatus;

  ClientState({
    this.surname = '',
    this.name = '',
    this.patronymic = '',
    this.phoneNumber = '',
    this.formStatus = const InitialFormStatus(),
    this.modelsStatus = const InitialModelsStatus(),
  });

  ClientState copyWith({
    String? surname,
    String? name,
    String? patronymic,
    String? phoneNumber,
    FormSubmissionStatus? formStatus,
    GetModelsStatus? modelsStatus,
  }) {
    return ClientState(
      surname: surname ?? this.surname,
      name: name ?? this.name,
      patronymic: patronymic ?? this.patronymic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      formStatus: formStatus ?? this.formStatus,
      modelsStatus: modelsStatus ?? this.modelsStatus,
    );
  }
}
