part of 'type_bloc.dart';

class TypeState {
  final String name;
  final GetModelsStatus modelsStatus;
  final FormSubmissionStatus formStatus;
  final DeleteStatus deleteStatus;
  final String message;

  TypeState({
    this.name = '',
    this.modelsStatus = const InitialModelsStatus(),
    this.formStatus = const InitialFormStatus(),
    this.message = '',
    this.deleteStatus = const InitialDeleteStatus(),
  });

  TypeState copyWith({
    String? name,
    GetModelsStatus? modelsStatus,
    String? message,
    DeleteStatus? deleteStatus,
    FormSubmissionStatus? formStatus,
  }) {
    return TypeState(
      formStatus: formStatus ?? this.formStatus,
      message: message ?? this.message,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      name: name ?? this.name,
      modelsStatus: modelsStatus ?? this.modelsStatus,
    );
  }
}
