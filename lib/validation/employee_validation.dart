import 'package:auto_service/blocs/employee_bloc/employee_bloc.dart';

class EmployeeValidation{
  EmployeeValidation();
  String? isValidLogin({required EmployeeState state, String? currentLogin}){
    if (!state.isValidLogin(currentLogin)) {
      return "Это обязательное поле";
    } else if (!state.isValidLoginLength) {
      return "Минимальная длина 3 символа";
    }
    else {
      return null;
    }
  }

  String? isValidPassword(EmployeeState state){
    if (!state.isValidPassword) {
      return "Это обязательное поле";
    } else if (!state.isValidPasswordLength) {
      return "Минимальная длина 8 символа";
    } else if (!state.isValidPasswordRegex) {
      return "Должны присутствовать цифры и заглавные символы";
    }
    else {
      return null;
    }
  }
}