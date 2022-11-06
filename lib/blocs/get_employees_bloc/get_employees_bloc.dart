import 'package:auto_service/blocs/get_models_status.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/dto/employee_dto.dart';
import '../../services/get_employees.dart';

part 'get_employees_event.dart';

part 'get_employees_state.dart';

class GetEmployeesBloc extends Bloc<GetEmployeesEvent, GetEmployeesState> {
  final GetEmployeesService getEmployeesService;

  GetEmployeesBloc({required this.getEmployeesService})
      : super(GetEmployeesState()) {
    on<GetListEmployeesEvent>(
        (event, emit) async => _onGetListEmployeesEvent(event, emit));

    on<SortBySurname>(
        (event, emit) async => _onSortBy(event, emit, 'sort', 'surname'));
    on<SortByRole>(
        (event, emit) async => _onSortBy(event, emit, 'sort', 'role'));
    on<SortBySalary>(
        (event, emit) async => _onSortBy(event, emit, 'sort', 'salary'));
    on<SortBySalaryDesc>(
        (event, emit) async => _onSortBy(event, emit, 'sortDesc', 'salary'));

    on<SearchChangedEvent>(
        (event, emit) => emit(state.copyWith(searchQuery: event.query)));
    on<SearchEmployeeEvent>(
        (event, emit) async => _onSortBy(event, emit, 'search', event.query));

    on<NoneEvent>(
        (event, emit) => emit(state.copyWith(modelsStatus: Submitting())));
  }

  void _onSortBy(GetEmployeesEvent event, Emitter<GetEmployeesState> emit,
      String func, String query) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<EmployeeDto> employees =
          await getEmployeesService.getEmployees(function: func, query: query);
      emit(state.copyWith(
          modelsStatus:
              SubmissionSuccess<EmployeeDto>(listEntities: employees)));
    } catch (error) {
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }

  void _onGetListEmployeesEvent(
      GetEmployeesEvent event, Emitter<GetEmployeesState> emit) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<EmployeeDto> employees = await getEmployeesService.getEmployees();
      emit(state.copyWith(
          modelsStatus:
              SubmissionSuccess<EmployeeDto>(listEntities: employees)));
    } catch (error) {
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }
}
