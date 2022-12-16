import 'package:auto_service/data/dto/autopart_order_dto.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/data/dto/service_order_dto.dart';

class OrderDto {
  int? id;
  int? carId;
  int? employeeId;
  String? status;
  CarDto? car;
  ClientDto? client;
  EmployeeDto? employee;
  List<AutopartOrderDto>? autoparts;
  List<ServiceOrderDto>? services;
  DateTime? dateCreated;

  OrderDto(
      {this.id,
      this.carId,
      this.employeeId,
      this.status,
      this.car,
      this.client,
      this.employee,
      this.autoparts,
      this.services,
      this.dateCreated});

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

  OrderDto.fromCar(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        carId = json['car_id'],
        employeeId = json['employee_id'],
        dateCreated = DateTime.parse(json['created_at']);

  double calculatePriceAutoparts(AutopartOrderDto autopart) =>
      autopart.count! * autopart.autopart!.salePrice!;

  double calculateFullPrice() {
    double fullPrice = 0.0;
    for (var autopart in autoparts!) {
      fullPrice += autopart.count! * autopart.autopart!.salePrice!;
    }
    for (var service in services!) {
      fullPrice += service.service!.price!;
    }
    return fullPrice;
  }

  Map<String, dynamic> toJson() => {
        'car_id': car!.id,
        'employee_id': employee!.id,
        'service_id': services?.first.service?.id,
        'autopart_id': autoparts?.first.autopart?.id,
        'count_autopart': autoparts?.first.count,
        'status': status
      };
}
