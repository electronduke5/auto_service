import '../../data/dto/employee_dto.dart';

abstract class LoginRepository {
  Future<EmployeeDto> login(String login, String password);
}
