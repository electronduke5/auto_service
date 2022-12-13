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

  CarDto(
      {this.id,
      this.vinNumber,
      this.carNumber,
      this.model,
      this.mileage,
      this.client,
      this.clientId,
      this.orders});

  CarDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        vinNumber = json['VIN_number'],
        carNumber = json['car_number'],
        model = json['model'],
        mileage = double.parse(json['mileage'].toString()),
        orders = (json['orders'] as List)
            .map((orderJson) => OrderDto.fromCar(orderJson))
            .toList(),
        clientId = json['client_id'];

  CarDto.fromJsonCar(Map<String, dynamic> json)
      : id = json['id'],
        vinNumber = json['VIN_number'],
        carNumber = json['car_number'],
        model = json['model'],
        mileage = double.parse(json['mileage'].toString()),
        clientId = json['client_id'],
        orders = (json['orders'] as List)
            .map((orderJson) => OrderDto.fromCar(orderJson))
            .toList(),
        client = (json['client'] as List)
            .map((jsonClient) => ClientDto.fromJsonCar(jsonClient))
            .first;

  Map<String, dynamic> toJson() => {
        'model': model,
        'car_number': carNumber,
        'VIN_number': vinNumber,
        'mileage': mileage?.toDouble(),
        'client_id': client!.id
      };
}
