import 'package:auto_service/data/dto/service_dto.dart';

class ServiceTypeDto {
  int? id;
  String? name;
  List<ServiceDto>? services;

  ServiceTypeDto({this.id, this.name, this.services});

  ServiceTypeDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        services = (json['services'] as List)
            .map((service) => ServiceDto.fromTypeJson(service))
            .toList();

  ServiceTypeDto.fromServiceJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {'name': name};
}
