import 'package:dio/dio.dart';

class ApiService<T> {
  Future<List<T>> getEntities(
    String apiRoute,
    T Function(Map<String, dynamic>) entityProducer,
  ) async {
    final dio = Dio(BaseOptions(
        followRedirects: false, validateStatus: (status) => status! < 500));

    final response = await dio.get(apiRoute);

    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      return data.map((json) => entityProducer(json)).toList();
    } else {
      throw Exception('Что-то пошло не так! (apiService.dart 19 строка)');
    }
  }

  Future<T> getEntity(
      {required String apiRoute,
      required T Function(Map<String, dynamic>) entityProducer,
      required Map<String, dynamic> dataJson}) async {
    final dio = Dio(
        BaseOptions(
            followRedirects: false,
            validateStatus: (status) => status! < 500
        ),
    );

    final response = await dio.post(apiRoute, data: dataJson);

    if (response.statusCode == 200) {
      final data = response.data['data'];
      return entityProducer(data);
    } else {
      throw Exception('Что-то пошло не так! (api_service.dart 38 строка)');
    }
  }
}
