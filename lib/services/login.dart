import 'package:auto_service/services/api_service.dart';
import 'package:auto_service/services/const_api_route.dart';

import '../data/dto/employee_dto.dart';
import '../domain/models/login_model.dart';

class LoginService extends ApiService<EmployeeDto> {
  @override
  String apiRoute = ApiConstUrl.authorizationUrl;

  Future<EmployeeDto> login(String login, String password) => getEntity(
      entityProducer: (Map<String, dynamic> json) => EmployeeDto.fromJson(json),
      dataJson: LoginModel(login, password).toJson());
}
