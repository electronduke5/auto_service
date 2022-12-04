import 'package:auto_service/data/dto/order_dto.dart';
import 'package:auto_service/services/api_service.dart';

class OrderService extends ApiService<OrderDto> {
  Future<List<OrderDto>> getOrders({String? function, String? query}) {
    return getEntities(
        apiRoute: 'http://127.0.0.1:8000/api/orders',
        entityProducer: (json) => OrderDto.fromJson(json),
        query: query,
        function: function);
  }
}
