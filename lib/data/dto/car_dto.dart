import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/data/dto/order_dto.dart';

class CarDto {
  int? id;
  String? vinNumber;
  String? carNumber;
  String? model;
  double? mileage;
  ClientDto? client;
  int? clientId;
  List<OrderDto>? orders;

  CarDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        vinNumber = json['VIN_number'],
        carNumber = json['car_number'],
        model = json['model'],
        mileage = json['mileage'],
        clientId = json['client_id'];

  CarDto.fromJsonCar(Map<String, dynamic> json)
      : id = json['id'],
        vinNumber = json['VIN_number'],
        carNumber = json['car_number'],
        model = json['model'],
        mileage = json['mileage'],
        clientId = json['client_id'],
        client = (json['client'] as List)
            .map((jsonClient) => ClientDto.fromJsonCar(jsonClient))
            .first;
}
