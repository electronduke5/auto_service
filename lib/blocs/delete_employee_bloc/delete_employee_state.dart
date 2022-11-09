part of 'delete_employee_bloc.dart';

class DeleteEmployeeState {
  final String message;
  final DeleteStatus modelsStatus;

  DeleteEmployeeState(
      {this.message = '', this.modelsStatus = const InitialDeleteStatus()});

  DeleteEmployeeState copyWith({DeleteStatus? modelsStatus, String? message}) {
    return DeleteEmployeeState(
        modelsStatus: modelsStatus ?? this.modelsStatus,
        message: message ?? this.message);
  }
}
