import 'package:intl/intl.dart';
class AccountantDto {
  int? id;
  String? description;
  double? profit;
  double? expense;
  DateTime? dateCreated;

  AccountantDto({
    this.id,
    this.description,
    this.expense,
    this.profit,
    this.dateCreated,
  });

  AccountantDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        profit = json['profit'] == null ? 0.0 : double.parse(json['profit'].toString()),
        expense = json['expense'] == null ? 0.0 : double.parse(json['expense'].toString()),
        dateCreated = DateFormat('dd.MM.yyyy').parse(json['created_at']);

}
