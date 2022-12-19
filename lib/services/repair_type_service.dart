import 'package:auto_service/data/dto/service_type_dto.dart';
import 'package:auto_service/services/api_service.dart';
import 'package:auto_service/services/const_api_route.dart';

class RepairTypeService extends ApiService<ServiceTypeDto> {
  @override
  String apiRoute = ApiConstUrl.typesUrl;

  Future<List<ServiceTypeDto>> getTypes() {
    return getEntities(
      entityProducer: (json) => ServiceTypeDto.fromJson(json),
    );
  }

  Future<ServiceTypeDto> addType({
    required ServiceTypeDto type,
  }) =>
      getEntity(
        entityProducer: (Map<String, dynamic> json) =>
            ServiceTypeDto.fromJson(json),
        dataJson: type.toJson(),
      );

  Future<ServiceTypeDto> editType({required ServiceTypeDto type}) {
    Map<String, dynamic> serviceJson = type.toJson();
    serviceJson.addAll({'_method': 'PUT'});

    return getEntity(
        id: type.id,
        entityProducer: (Map<String, dynamic> json) =>
            ServiceTypeDto.fromJson(json),
        dataJson: serviceJson);
  }

  Future deleteType({required int id}) => deleteEntity(id: id);
}
