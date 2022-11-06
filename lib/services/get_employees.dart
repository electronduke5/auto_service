import 'package:auto_service/services/api_service.dart';

import '../data/dto/employee_dto.dart';

class GetEmployeesService extends ApiService<EmployeeDto> {
  Future<List<EmployeeDto>> getEmployees({String? function, String? query}) {
    return getEntities(apiRoute: 'http://127.0.0.1:8000/api/employees',
        entityProducer: (json) => EmployeeDto.fromJson(json),
    function: function,
    query: query);
  }
}