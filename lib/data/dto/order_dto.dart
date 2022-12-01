import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/data/dto/employee_dto.dart';

class OrderDto {
  int? id;
  String? status;
  CarDto? car;
  ClientDto? client;
  EmployeeDto? employee;
  AutopartDto? autoparts;
}
