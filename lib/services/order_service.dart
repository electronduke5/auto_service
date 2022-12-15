import 'package:auto_service/data/dto/order_dto.dart';
import 'package:auto_service/services/api_service.dart';
import 'package:auto_service/services/const_api_route.dart';

class OrderService extends ApiService<OrderDto> {
  @override
  String apiRoute = ApiConstUrl.ordersUrl;

  Future<List<OrderDto>> getOrders({String? function, String? query}) {
    return getEntities(
        //apiRoute: 'http://127.0.0.1:8000/api/orders',
        entityProducer: (json) => OrderDto.fromJson(json),
        query: query,
        function: function);
  }

  Future<OrderDto> getOrder(int id) {
    return getEntity(
        //apiRoute: 'http://127.0.0.1:8000/api/orders/$id',
        entityProducer: (json) => OrderDto.fromJson(json),
        dataJson: {});
  }
}
