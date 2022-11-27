import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/services/api_service.dart';

class EmployeeService extends ApiService<EmployeeDto> {

  Future<List<EmployeeDto>> getEmployees({String? function, String? query}) {
    return getEntities(apiRoute: 'http://127.0.0.1:8000/api/employees',
        entityProducer: (json) => EmployeeDto.fromJson(json),
        function: function,
        query: query);
  }

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

  Future deleteEmployee({required int id}) =>
      deleteEntity(apiRoute: 'http://127.0.0.1:8000/api/employees/$id');

  Future<EmployeeDto> editEmployee({
    required int id,
    required String login,
    String? password,
    required String surname,
    required String name,
    String? patronymic,
    required String role,
    required int salary,
  }) {
    Map<String, dynamic> employeeJson = EmployeeDto(
      surname: surname,
      name: name,
      patronymic: patronymic,
      login: login,
      role: role,
      salary: salary,
    ).toJson();
    employeeJson.addAll({'_method' : 'PUT'});

    return getEntity(
        apiRoute: 'http://127.0.0.1:8000/api/employees/$id',
        entityProducer: (Map<String, dynamic> json) =>
            EmployeeDto.fromJson(json),
        dataJson: employeeJson);
  }
}
