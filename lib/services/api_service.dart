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
    if(function != null && query != null ){
      response = await dio.get('$apiRoute?$function=$query');
    }
    else{
      response = await dio.get(apiRoute);
    }


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

    print(dataJson[0]);
    print(dataJson[1]);
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
      throw Exception('Что-то пошло не так! (api_service.dart 38 строка)');
    }
  }
}
