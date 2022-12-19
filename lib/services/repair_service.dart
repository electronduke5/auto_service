import 'package:auto_service/data/dto/service_dto.dart';
import 'package:auto_service/services/api_service.dart';
import 'package:auto_service/services/const_api_route.dart';

class RepairService extends ApiService<ServiceDto> {
  @override
  String apiRoute = ApiConstUrl.serviceUrl;

  Future<List<ServiceDto>> getServices() {
    return getEntities(
      entityProducer: (json) => ServiceDto.fromJson(json),
    );
  }

  Future<ServiceDto> addService({
    required ServiceDto service,
  }) =>
      getEntity(
        entityProducer: (Map<String, dynamic> json) =>
            ServiceDto.fromJson(json),
        dataJson: service.toJson(),
      );

  Future<ServiceDto> editService({required ServiceDto service}) {
    Map<String, dynamic> serviceJson = service.toJson();
    serviceJson.addAll({'_method': 'PUT'});

    return getEntity(
        id: service.id,
        entityProducer: (Map<String, dynamic> json) =>
            ServiceDto.fromJson(json),
        dataJson: serviceJson);
  }

  Future deleteService({required int id}) => deleteEntity(id: id);
}
