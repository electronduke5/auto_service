import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/services/api_service.dart';

class AutopartService extends ApiService<AutopartDto> {
  Future<List<AutopartDto>> getAutoparts() {
    return getEntities(
      apiRoute: 'http://127.0.0.1:8000/api/autoparts',
      entityProducer: (json) => AutopartDto.fromJson(json),
    );
  }

  Future<AutopartDto> addAutopart({
    required AutopartDto autopart,
  }) =>
      getEntity(
        apiRoute: 'http://127.0.0.1:8000/api/autoparts',
        entityProducer: (Map<String, dynamic> json) =>
            AutopartDto.fromJson(json),
        dataJson: autopart.toJson(),
      );

  Future<AutopartDto> editCount({required AutopartDto autopart}) {
    Map<String, dynamic> autopartJson = autopart.toJson();
    autopartJson.addAll({'_method': 'PUT'});

    return getEntity(
        apiRoute: 'http://127.0.0.1:8000/api/autoparts/${autopart.id}',
        entityProducer: (Map<String, dynamic> json) =>
            AutopartDto.fromJson(json),
        dataJson: autopartJson);
  }
}
