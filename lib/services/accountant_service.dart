import 'package:auto_service/data/dto/accountant_dto.dart';
import 'package:auto_service/services/api_service.dart';
import 'package:auto_service/services/const_api_route.dart';

class AccountantService extends ApiService<AccountantDto>{
  @override
  String apiRoute = ApiConstUrl.accountantUrl;

  Future<List<AccountantDto>> getAccountants({String? function, String? query}) {
    return getEntities(
        entityProducer: (json) => AccountantDto.fromJson(json),
        function: function,
        query: query);
  }
}