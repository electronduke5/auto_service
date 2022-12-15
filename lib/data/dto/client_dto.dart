import 'package:auto_service/data/dto/car_dto.dart';
import 'package:dartx/dartx.dart';

class ClientDto {
  int? id;
  String? surname;
  String? name;
  String? patronymic;
  String? phoneNumber;
  List<CarDto>? cars;

  ClientDto({
    this.id,
    this.surname,
    this.name,
    this.patronymic,
    this.phoneNumber
});

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

  ClientDto.fromOrder(Map<String, dynamic> json)
      : id = json['id'],
        surname = json['surname'],
        name = json['name'],
        patronymic = json['patronymic'],
        phoneNumber = json['phone_number'];

  ClientDto.fromJsonCar(Map<String, dynamic> json)
      : id = json['id'],
        surname = json['surname'],
        name = json['name'],
        patronymic = json['patronymic'],
        phoneNumber = json['phone_number'],
        cars = (json['cars'] as List)
            .map((jsonCar) => CarDto.fromJson(jsonCar))
            .toList();

  Map<String, dynamic> toJson() => {
        'surname': surname,
        'name': name,
        'patronymic': patronymic,
        'phone_number': phoneNumber,
      };
}
