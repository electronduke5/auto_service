import 'package:auto_service/data/dto/category_dto.dart';

class AutopartDto {
  int? id;
  String? name;
  int? purchasePrice;
  int? salePrice;
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
        purchasePrice = json['purchase_price'],
        salePrice = json['sale_price'],
        count = json['count'],
        category = CategoryDto.fromJson(json['category']);
}
