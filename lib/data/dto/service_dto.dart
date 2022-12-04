import 'package:auto_service/data/dto/service_type_dto.dart';

class ServiceDto {
  int? id;
  String? description;
  int? serviceTypeId;
  ServiceTypeDto? type;

  ServiceDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        type = ServiceTypeDto.fromServiceJson(json['type']);

  ServiceDto.fromTypeJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        serviceTypeId = json['service_type_id'];
}
