import 'dart:async';

import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/domain/models/employee.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/dto/employee_dto.dart';
import '../../services/get_employees.dart';

part 'get_employees_event.dart';
part 'get_employees_state.dart';

class GetEmployeesBloc extends Bloc<GetEmployeesEvent, GetEmployeesState> {
  final GetEmployeesService getEmployeesService;

  GetEmployeesBloc({required this.getEmployeesService}) : super(GetEmployeesState()) {
    on<GetListEmployeesEvent>((event, emit) async{
      print("get_employees_bloc line 19");
      emit(state.copyWith(modelsStatus: Submitting()));
      try{
        print("get_employees_bloc line 21");
        List<EmployeeDto> employees = await getEmployeesService.getEmployees();
        print(employees.toString());
        emit(state.copyWith(modelsStatus: SubmissionSuccess<EmployeeDto>(listEntities: employees)));
        print("success");
      } catch(error){
        print("Error");
        emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
        //emit(state.copyWith(modelsStatus: const InitialModelsStatus()));
      }
    });

    on<NoneEvent>((event, emit) => emit(state.copyWith(modelsStatus: Submitting())));
  }
}
