class CategoryDto {
  int? id;
  String? name;

  CategoryDto({this.id, this.name});

  CategoryDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['category_name'];

  Map<String, dynamic> toJson() => {'category_name': name};
}
