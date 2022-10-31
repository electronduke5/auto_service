import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../data/dto/employee_dto.dart';
import '../../domain/models/employee.dart';
import '../../services/login.dart';
import '../form_submission_status.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService;

  LoginBloc({required this.loginService}) : super(LoginState()) {
    on<LoginChanged>((event, emit) => emit(state.copyWith(login: event.login)));
    on<PasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<LoginSubmitted>((event, emit) => _onLoginSubmitted(event, emit));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      EmployeeDto employee = await loginService.login(event.login, event.password);
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    } catch (error) {
      emit(state.copyWith(formStatus: SubmissionFailed(error.toString())));
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    }
  }
}
