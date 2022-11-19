import 'package:auto_service/data/dto/category_dto.dart';
import 'package:auto_service/services/api_service.dart';

class CategoryService extends ApiService<CategoryDto> {
  Future<List<CategoryDto>> getCategories() {
    return getEntities(
        apiRoute: 'http://127.0.0.1:8000/api/categories',
        entityProducer: (json) => CategoryDto.fromJson(json));
  }
}
