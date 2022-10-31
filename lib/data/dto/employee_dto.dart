import 'package:collection/collection.dart';

class EmployeeDto {
  int id;
  String? surname;
  String? name;
  String? patronymic;
  int? salary;
  String? login;
  String? password;
  String? role;
  List<dynamic>? orders;

  EmployeeDto(
      {required this.id,
      this.surname,
      this.name,
      this.patronymic,
      this.salary,
      this.login,
      this.password,
      this.role,
      this.orders});

  getFullName() {
    return [surname, name, patronymic].whereNotNull().join(" ");
  }

  EmployeeDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        surname = json['surname'],
        name = json['name'],
        patronymic = json['patronymic'],
        salary = json['salary'],
        login = json['login'],
        password = json['password'],
        role = json['role'],
  //TODO: Сделать преобразование в лсит fromJson
        orders = json['orders'] as List<dynamic>;

  Map<String, dynamic> toJson() => {
    'id': id,
    'surname': surname,
    'name': name,
    'patronymic': patronymic,
    'salary': salary,
    'login': login,
    'password': password,
    'role': role,
    'orders': orders,
  };
}
