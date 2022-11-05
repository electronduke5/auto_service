import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'hr_navigation_event.dart';

part 'hr_navigation_state.dart';

class HrNavigationBloc extends Bloc<HrNavigationEvent, HrNavigationState> {
  HrNavigationBloc() : super(HrInViewState()) {
    on<HrNavigationEvent>((event, emit) {});

    on<ToProfilePage>((event, emit) =>
        emit(HrInProfileState(loggedEmployee: event.loggedEmployee)));

    on<ToAddEmployeePage>((event, emit) => emit(HrInAddState()));
    on<ToEmployeesPage>((event, emit) => emit(HrInViewState()));
  }
}
