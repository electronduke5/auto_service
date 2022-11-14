import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/services/api_service.dart';

class AutopartsService extends ApiService<AutopartDto> {
  Future<List<AutopartDto>> getAutoparts() {
    return getEntities(
      apiRoute: 'http://127.0.0.1:8000/api/autoparts',
      entityProducer: (json) => AutopartDto.fromJson(json),
    );
  }
}
