part of 'get_employees_bloc.dart';

class GetEmployeesState{
  final GetModelsStatus modelsStatus;
  //List<EmployeeDto>? employees;

  GetEmployeesState({this.modelsStatus = const InitialModelsStatus()});

  GetEmployeesState copyWith({GetModelsStatus? modelsStatus}){
    return GetEmployeesState(
      modelsStatus: modelsStatus ?? this.modelsStatus,
      //list: modelsStatus is SubmissionSuccess<EmployeeDto>? modelsStatus.entities :
    );
  }
}
