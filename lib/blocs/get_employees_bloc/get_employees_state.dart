part of 'get_employees_bloc.dart';

class GetEmployeesState {
  final GetModelsStatus modelsStatus;
  final String searchQuery;

  //List<EmployeeDto>? employees;

  GetEmployeesState(
      {this.modelsStatus = const InitialModelsStatus(), this.searchQuery = ''});

  GetEmployeesState copyWith(
      {GetModelsStatus? modelsStatus, String? searchQuery}) {
    return GetEmployeesState(
        modelsStatus: modelsStatus ?? this.modelsStatus,
        searchQuery: searchQuery ?? this.searchQuery
        );
  }
}
