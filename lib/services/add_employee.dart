import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/services/api_service.dart';

class EmployeeService extends ApiService<EmployeeDto> {
  Future<EmployeeDto> addEmployee({
    required String login,
    required String password,
    required String surname,
    required String name,
    String? patronymic,
    required String role,
    required int salary,
  }) =>
      getEntity(
          apiRoute: 'http://127.0.0.1:8000/api/employees',
          entityProducer: (Map<String, dynamic> json) =>
              EmployeeDto.fromJson(json),
          dataJson: EmployeeDto(
            surname: surname,
            name: name,
            patronymic: patronymic,
            login: login,
            password: password,
            role: role,
            salary: salary,
          ).toJson());
  
  Future deleteEmployee({required int id}) => deleteEntity(apiRoute: 'http://127.0.0.1:8000/api/employees/$id');
}
