import 'package:auto_service/services/api_service.dart';
import 'package:dio/dio.dart';

import '../data/dto/employee_dto.dart';

class GetEmployeesService extends ApiService<EmployeeDto>{

  Future<List<EmployeeDto>> getEmployees() {
    print("object");
    return getEntities('http://127.0.0.1:8000/api/employees', (json) => EmployeeDto.fromJson(json));
  }



  // Future<List<EmployeeDto>> getEmployees() async{
  //   const api = 'http://127.0.0.1:8000/api/employees';
  //   final dio = Dio();
  //   final response = await dio.get(api, options: Options(
  //     followRedirects: false,
  //     validateStatus: (status) => status! < 500
  //   ));
  //
  //   print("Status code: ${response.statusCode}");
  //   print("Body: ${response.data}");
  //
  //   if(response.statusCode == 200){
  //     final data = response.data['data'] as List;
  //     var listEmployees = data.map((employee) => EmployeeDto.fromJson(employee)).toList();
  //     return listEmployees;
  //   } else{
  //     throw Exception('Что-то пошло не так! (get_employees.dart 22 строка)');
  //   }
  // }
}