import 'package:dio/dio.dart';

class ApiService<T> {
  Future<List<T>> getEntities({
    required String apiRoute,
    required T Function(Map<String, dynamic>) entityProducer,
    String? function,
    String? query,
  }) async {
    final dio = Dio(BaseOptions(
        followRedirects: false, validateStatus: (status) => status! < 500));

    final response;
    if (function != null && query != null) {
      response = await dio.get('$apiRoute?$function=$query');
    } else {
      response = await dio.get(apiRoute);
    }
    //print("StatusCode: ${response.statusCode}");
    //print("data: ${response.data}");
    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      return data.map((json) => entityProducer(json)).toList();
    } else {
      throw response.data['message'];
    }
  }

  Future<T> getEntity(
      {required String apiRoute,
      required T Function(Map<String, dynamic>) entityProducer,
      required Map<String, dynamic> dataJson}) async {
    final dio = Dio(
      BaseOptions(
          headers: {"Accept": "application/json"},
          followRedirects: false,
          validateStatus: (status) => status! < 500),
    );

    print("isNotEmpty: ${dataJson.isNotEmpty}");
    print("length: ${dataJson.length}");
    print("values: ${dataJson.values}");
    print(apiRoute);
    final response = await dio.post(apiRoute, data: dataJson);

    print("StatusCode: ${response.statusCode}");
    print("data: ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data['data'];
      return entityProducer(data);
    } else {
      print('Error Message (api_service 54): ${response.data['message']}');
      throw response.data['message'];
    }
  }

  Future deleteEntity(
      {required String apiRoute}) async {
    final dio = Dio(
      BaseOptions(
          headers: {"Accept": "application/json"},
          followRedirects: false,
          validateStatus: (status) => status! < 500),
    );
    final response = await dio.post(apiRoute, data: {"_method" : "DELETE"});

    print("StatusCode: ${response.statusCode}");
    print("data: ${response.data}");

    if (response.statusCode == 204) {
      final data = response.data['data'];
      return data['message'];
    } else {
      print('Error Message (api_service 74): ${response.data['message']}');
      throw response.data['message'];
    }
  }
}
