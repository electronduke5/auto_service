class UserModel {
  final int id;
  final String surname;
  final String name;
  final String? patronymic;
  final int salary;
  final String login;
  final String password;
  final String role;
  final List? orders;

  UserModel(this.id, this.surname, this.name, this.patronymic, this.salary,
      this.login, this.password, this.role, this.orders);


  getFullName(){
    return "$surname $name";
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        surname = json['surname'],
        name = json['name'],
        patronymic = json['patronymic'],
        salary = json['salary'],
        login = json['login'],
        password = json['password'],
        role = json['role'],
        orders = json['orders'];

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
