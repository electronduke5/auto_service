import 'package:auto_service/data/dto/service_type_dto.dart';

class ServiceDto {
  int? id;
  String? description;
  int? serviceTypeId;
  double? price;
  ServiceTypeDto? type;

  ServiceDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = double.parse(json['price'].toString()),
        description = json['description'],
        type = ServiceTypeDto.fromServiceJson(json['type']);

  ServiceDto.fromTypeJson(Map<String, dynamic> json)
      : id = json['id'],
        price = double.parse(json['price'].toString()),
        description = json['description'],
        serviceTypeId = json['service_type_id'];
}
