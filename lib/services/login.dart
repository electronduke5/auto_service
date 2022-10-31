import 'package:auto_service/services/api_service.dart';

import '../data/dto/employee_dto.dart';
import '../domain/models/login_model.dart';

class LoginService extends ApiService<EmployeeDto> {
  Future<EmployeeDto> login(String login, String password) => getEntity(
      apiRoute: 'http://127.0.0.1:8000/api/login',
      entityProducer: (Map<String, dynamic> json) => EmployeeDto.fromJson(json),
      dataJson: LoginModel(login, password).toJson());
}
