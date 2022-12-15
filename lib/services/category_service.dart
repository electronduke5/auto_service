import 'package:auto_service/data/dto/category_dto.dart';
import 'package:auto_service/services/api_service.dart';
import 'package:auto_service/services/const_api_route.dart';

class CategoryService extends ApiService<CategoryDto> {
  @override
  String apiRoute = ApiConstUrl.categoriesUrl;

  Future<List<CategoryDto>> getCategories() {
    return getEntities(entityProducer: (json) => CategoryDto.fromJson(json));
  }
}
