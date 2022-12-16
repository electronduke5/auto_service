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
}
