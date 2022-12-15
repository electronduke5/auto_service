import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/services/api_service.dart';
import 'package:auto_service/services/const_api_route.dart';

class ClientService extends ApiService<ClientDto> {
  @override
  String apiRoute = ApiConstUrl.clientsUrl;

  Future<List<ClientDto>> getClients({String? function, String? query}) {
    return getEntities(
      entityProducer: (json) => ClientDto.fromJson(json),
      query: query,
      function: function,
    );
  }

  Future<ClientDto> addClient({
    required ClientDto client,
  }) =>
      getEntity(
        entityProducer: (Map<String, dynamic> json) =>
            ClientDto.fromJsonCar(json),
        dataJson: client.toJson(),
      );

  Future<ClientDto> editClient({required ClientDto client}) {
    Map<String, dynamic> clientJson = client.toJson();
    clientJson.addAll({'_method': 'PUT'});

    return getEntity(
      id: client.id,
      //apiRoute: 'http://127.0.0.1:8000/api/clients/${client.id}',
      entityProducer: (Map<String, dynamic> json) => ClientDto.fromJson(json),
      dataJson: clientJson,
    );
  }

  Future deleteClient({required int id}) => deleteEntity(id: id);
}
