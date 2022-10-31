import 'package:auto_service/services/api_service.dart';

import '../data/dto/employee_dto.dart';

class GetEmployeesService extends ApiService<EmployeeDto> {
  Future<List<EmployeeDto>> getEmployees() {
    return getEntities('http://127.0.0.1:8000/api/employees',
        (json) => EmployeeDto.fromJson(json));
  }
}