class Employee {
  int? id;
  String? surname;
  String? name;
  String? patronymic;
  int? salary;
  String? login;
  String? password;
  String? role;
  List<dynamic>? orders;

  //String? error;

  Employee(this.id, this.surname, this.name, this.patronymic, this.salary,
      this.login, this.password, this.role, this.orders);

  getFullName() {
    return "$surname $name";
  }
}
