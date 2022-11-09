import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../data/dto/employee_dto.dart';
import '../../services/add_employee.dart';

part 'add_employee_event.dart';

part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  final EmployeeService addEmployeeService;

  AddEmployeeBloc({required this.addEmployeeService})
      : super(AddEmployeeState()) {
    on<LoginChanged>((event, emit) => emit(state.copyWith(login: event.login)));
    on<PasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<SurnameChanged>(
        (event, emit) => emit(state.copyWith(surname: event.surname)));
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.name)));
    on<PatronymicChanged>(
        (event, emit) => emit(state.copyWith(patronymic: event.patronymic)));

    on<RoleChanged>((event, emit) => emit(state.copyWith(role: event.role)));
    on<SalaryChanged>(
        (event, emit) => emit(state.copyWith(salary: event.salary)));

    on<FormSubmitted>((event, emit) => _onFormSubmitted(event, emit));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<AddEmployeeState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      EmployeeDto employee = await addEmployeeService.addEmployee(
        surname: event.surname,
        name: event.name,
        patronymic: event.patronymic,
        login: event.login,
        password: event.password,
        salary: event.salary,
        role: event.role,
      );
      emit(state.copyWith(formStatus: FormSubmissionSuccess(employee)));
      emit(state.copyWith(
          formStatus: const InitialFormStatus(),
          surname: '',
          name: '',
          password: '',
          login: '',
          role: '',
          patronymic: '',
          salary: 0));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    }
  }
}
