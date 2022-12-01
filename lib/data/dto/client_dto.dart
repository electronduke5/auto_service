import 'package:auto_service/data/dto/car_dto.dart';
import 'package:dartx/dartx.dart';

class ClientDto {
  int? id;
  String? surname;
  String? name;
  String? patronymic;
  String? phoneNumber;
  List<CarDto>? cars;

  getFullName() {
    return [surname, name, patronymic].whereNotNull().join(" ");
  }

  ClientDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        surname = json['surname'],
        name = json['name'],
        patronymic = json['patronymic'],
        phoneNumber = json['phone_number'],
        cars = (json['cars'] as List)
            .map((jsonCar) => CarDto.fromJson(jsonCar))
            .toList();
}
