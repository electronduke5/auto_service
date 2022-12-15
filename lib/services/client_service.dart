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

  Future<ClientDto> editClient({
  required int id,
    required String surname,
    required String name,
    String? patronymic,
    required String phoneNumber,
  }) {
    Map<String, dynamic> clientJson = ClientDto(
      surname: surname,
      name: name,
      patronymic: patronymic,
      phoneNumber: phoneNumber
    ).toJson();
    clientJson.addAll({'_method': 'PUT'});

    return getEntity(
      id: id,
      //apiRoute: 'http://127.0.0.1:8000/api/clients/${client.id}',
      entityProducer: (Map<String, dynamic> json) => ClientDto.fromJson(json),
      dataJson: clientJson,
    );
  }

  Future deleteClient({required int id}) => deleteEntity(id: id);
}
