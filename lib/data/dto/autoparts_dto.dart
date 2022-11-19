import 'package:auto_service/data/dto/category_dto.dart';

class AutopartDto {
  int? id;
  String? name;
  double? purchasePrice;
  double? salePrice;
  int? count;
  CategoryDto? category;

  AutopartDto(
      {this.id,
      this.name,
      this.count,
      this.purchasePrice,
      this.salePrice,
      this.category});

  AutopartDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        purchasePrice = json['purchase_price'].toDouble(),
        salePrice = json['sale_price'].toDouble(),
        count = json['count'],
        category = CategoryDto.fromJson(json['category']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'purchase_price': purchasePrice,
        'sale_price': salePrice,
        'count': count,
        'category_id': category!.id
      };
}
