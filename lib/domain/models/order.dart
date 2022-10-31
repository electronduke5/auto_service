class Order {
  int id;

  //TODO: Car car;
  int carId;
  int employeeId;
  String status;
  DateTime createdAt;

  Order(this.id, this.carId, this.employeeId, this.status, this.createdAt);

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        carId = json['carId'],
        employeeId = json['employeeId'],
        status = json['status'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'carId': carId,
        'employeeId': employeeId,
        'status': status,
        'createdAt': createdAt,
      };
}
