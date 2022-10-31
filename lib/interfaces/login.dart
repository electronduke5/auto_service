import 'package:dio/dio.dart';

import '../data/dto/employee_dto.dart';
import '../domain/models/login_model.dart';

abstract class ILogin {
  Future<EmployeeDto?> login2(String login, String password) async {
    const api = 'http://127.0.0.1:8000/api/login';

    final data = LoginModel(login, password).toJson();
    final dio = Dio();

    var response = await dio.post(api, data: data);

    if (response.statusCode == 200) {
      final body = response.data;
      return EmployeeDto.fromJson(body);
    } else {
      return null;
    }
  }
}
