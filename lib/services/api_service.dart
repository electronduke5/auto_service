import 'package:auto_service/services/const_api_route.dart';
import 'package:dio/dio.dart';

abstract class ApiService<T> extends ApiConstUrl {
  abstract String apiRoute;

  Future<List<T>> getEntities({
    required T Function(Map<String, dynamic>) entityProducer,
    String? function,
    String? query,
  }) async {
    final dio = Dio(BaseOptions(
        followRedirects: false, validateStatus: (status) => status! < 500));

    final response;
    if (function != null && query != null) {
      print("url: ${ApiConstUrl.baseUrl}$apiRoute?$function=$query");
      response =
          await dio.get('${ApiConstUrl.baseUrl}$apiRoute?$function=$query');
    } else {
      print("url: ${ApiConstUrl.baseUrl}$apiRoute");

      response = await dio.get('${ApiConstUrl.baseUrl}$apiRoute');
    }
    print("StatusCode: ${response.statusCode}");
    //print("data: ${response.data}");
    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      print(data.map((json) => entityProducer(json)).toList());
      return data.map((json) => entityProducer(json)).toList();
    } else {
      throw response.data['message'];
    }
  }

  Future<T> getEntity(
      {int? id,
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
    print('api route: ${ApiConstUrl.baseUrl}$apiRoute');
    final response = id == null
        ? await dio.post('${ApiConstUrl.baseUrl}$apiRoute', data: dataJson)
        : await dio.post('${ApiConstUrl.baseUrl}$apiRoute/${id.toString()}',
            data: dataJson);

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

  Future deleteEntity({required int id}) async {
    final dio = Dio(
      BaseOptions(
          headers: {"Accept": "application/json"},
          followRedirects: false,
          validateStatus: (status) => status! < 500),
    );
    final response = await dio.post(
        '${ApiConstUrl.baseUrl}$apiRoute/${id.toString()}',
        data: {"_method": "DELETE"});

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
