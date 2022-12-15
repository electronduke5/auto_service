part of 'client_bloc.dart';

class ClientState {
  final String surname;
  final String name;
  final String patronymic;
  final String phoneNumber;
  final FormSubmissionStatus formStatus;
  final GetModelsStatus modelsStatus;
  final String searchQuery;
  final String message;
  final DeleteStatus deleteStatus;

  ClientState({
    this.surname = '',
    this.name = '',
    this.patronymic = '',
    this.phoneNumber = '',
    this.formStatus = const InitialFormStatus(),
    this.modelsStatus = const InitialModelsStatus(),
    this.searchQuery = '',
    this.message = '',
    this.deleteStatus = const InitialDeleteStatus(),
  });

  ClientState copyWith({
    String? surname,
    String? name,
    String? patronymic,
    String? phoneNumber,
    FormSubmissionStatus? formStatus,
    GetModelsStatus? modelsStatus,
    String? searchQuery,
    String? message,
    DeleteStatus? deleteStatus,
  }) {
    return ClientState(
      surname: surname ?? this.surname,
      name: name ?? this.name,
      patronymic: patronymic ?? this.patronymic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      formStatus: formStatus ?? this.formStatus,
      modelsStatus: modelsStatus ?? this.modelsStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      message: message ?? this.message,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }
}
