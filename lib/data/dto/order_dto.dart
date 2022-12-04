import 'package:auto_service/data/dto/autopart_order_dto.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/data/dto/service_order_dto.dart';

class OrderDto {
  int? id;
  String? status;
  CarDto? car;
  ClientDto? client;
  EmployeeDto? employee;
  List<AutopartOrderDto>? autoparts;
  List<ServiceOrderDto>? services;

  OrderDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        car = CarDto.fromJson(json['car']),
        client = ClientDto.fromOrder(json['client']),
        employee = EmployeeDto.fromOrder(json['employee']),
        autoparts = (json['autoparts'] as List)
            .map((autopartJson) => AutopartOrderDto.fromJson(autopartJson))
            .toList(),
        services = (json['services'] as List)
            .map((serviceJson) => ServiceOrderDto.fromJson(serviceJson))
            .toList();
}
