import 'package:auto_service/data/dto/autoparts_dto.dart';

class AutopartOrderDto {
  int? count;
  AutopartDto? autopart;

  AutopartOrderDto.fromJson(Map<String, dynamic> json)
      : count = json['count_autopart'],
        autopart = (json['autopart'] as List)
            .map((autopartJson) => AutopartDto.fromJson(autopartJson))
            .first;
}
