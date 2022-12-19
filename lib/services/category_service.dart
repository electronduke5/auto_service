import 'package:auto_service/data/dto/category_dto.dart';
import 'package:auto_service/services/api_service.dart';
import 'package:auto_service/services/const_api_route.dart';

class CategoryService extends ApiService<CategoryDto> {
  @override
  String apiRoute = ApiConstUrl.categoriesUrl;

  Future<List<CategoryDto>> getCategories() {
    return getEntities(entityProducer: (json) => CategoryDto.fromJson(json));
  }

  Future<CategoryDto> addCategory({required CategoryDto category}) {
    return getEntity(
        entityProducer: (Map<String, dynamic> json) =>
            CategoryDto.fromJson(json),
        dataJson: category.toJson());
  }

  Future<CategoryDto> editCategory({required CategoryDto category}) {
    Map<String, dynamic> categoryJson = category.toJson();
    categoryJson.addAll({'_method': 'PUT'});

    return getEntity(
        id: category.id,
        entityProducer: (Map<String, dynamic> json) =>
            CategoryDto.fromJson(json),
        dataJson: categoryJson);
  }

  Future deleteCategory({required int id}) => deleteEntity(id: id);
}
