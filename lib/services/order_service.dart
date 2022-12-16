import 'package:auto_service/data/dto/order_dto.dart';
import 'package:auto_service/services/api_service.dart';
import 'package:auto_service/services/const_api_route.dart';

class OrderService extends ApiService<OrderDto> {
  @override
  String apiRoute = ApiConstUrl.ordersUrl;

  Future<List<OrderDto>> getOrders({String? function, String? query}) {
    return getEntities(
        entityProducer: (json) => OrderDto.fromJson(json),
        query: query,
        function: function);
  }

  Future<OrderDto> getOrder(int id) {
    return getEntity(
        entityProducer: (json) => OrderDto.fromJson(json),
        dataJson: {});
  }

  Future<OrderDto> addOrder({
    required OrderDto order,
  }) =>
      getEntity(
        entityProducer: (Map<String, dynamic> json) => OrderDto.fromJson(json),
        dataJson: order.toJson(),
      );

  Future<OrderDto> editOrder({required OrderDto order}) {
    Map<String, dynamic> orderJson = order.toJson();
    orderJson.addAll({'_method': 'PUT'});
    return getEntity(
        id: order.id,
        entityProducer: (Map<String, dynamic> json) => OrderDto.fromJson(json),
        dataJson: orderJson);
  }

  Future deleteOrder({required int id}) => deleteEntity(id: id);
}
