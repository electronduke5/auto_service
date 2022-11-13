import 'package:auto_service/blocs/delete_status.dart';
import 'package:auto_service/services/employee_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_employee_event.dart';

part 'delete_employee_state.dart';

class DeleteEmployeeBloc
    extends Bloc<DeleteEmployeeEvent, DeleteEmployeeState> {
  final EmployeeService employeeService;

  DeleteEmployeeBloc({required this.employeeService})
      : super(DeleteEmployeeState()) {
    on<DeleteEmployeeEvent>((event, emit) async {
      emit(state.copyWith(modelsStatus: SubmittingDelete()));
      try {
        String message = await employeeService.deleteEmployee(id: event.id);
        emit(state.copyWith(
            modelsStatus: SubmissionDeleteSuccess(successMessage: message)));
      } catch (error) {
        emit(state.copyWith(
            modelsStatus:
                SubmissionDeleteFailed(errorMessage: error.toString())));
        emit(state.copyWith(modelsStatus: const InitialDeleteStatus()));
      }
    });
  }
}
