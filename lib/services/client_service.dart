import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/services/api_service.dart';

class ClientService extends ApiService<ClientDto> {
  Future<List<ClientDto>> getClients({String? function, String? query}) {
    return getEntities(
      apiRoute: 'http://127.0.0.1:8000/api/clients',
      entityProducer: (json) => ClientDto.fromJson(json),
      query: query,
      function: function,
    );
  }
}
