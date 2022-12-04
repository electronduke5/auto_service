import 'package:auto_service/data/dto/service_dto.dart';

class ServiceOrderDto {
  ServiceDto? service;

  ServiceOrderDto.fromJson(Map<String, dynamic> json)
      : service = (json['service'] as List)
            .map((serviceJson) => ServiceDto.fromJson(serviceJson))
            .first;
}
