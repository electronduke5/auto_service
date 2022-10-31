import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:dio/dio.dart';

class ApiService<T>{
  Future<List<T>> getEntities(
      String apiRoute,
      T Function(Map<String, dynamic>) entityProducer,
      )async{
    final dio = Dio(BaseOptions(
      followRedirects: false,
      validateStatus:  (status) => status! < 500
    ));


    print('api route ${apiRoute}');
    final response = await dio.get(apiRoute);
    print("Status Code: ${response.statusCode}");
    if(response.statusCode == 200){
      final data = response.data['data'] as List;
      print(data);
      return data.map((json) => entityProducer(json)).toList();
    } else{
      throw Exception('Что-то пошло не так! (apiService.dart 19 строка)');
    }
  }

  Future<T> getEntity(
  { required String apiRoute,
      required T Function(Map<String, dynamic>) entityProducer,
      required Map<String, dynamic> dataJson}
      )async{
    final dio = Dio(BaseOptions(
        followRedirects: false,
        validateStatus:  (status) => status! < 500
    ));

    final response = await dio.post(apiRoute, data: dataJson);

    if(response.statusCode == 200){
      final data = response.data['data'];
      return entityProducer(data);
    } else{
      throw Exception('Что-то пошло не так! (get_employees.dart 22 строка)');
    }
  }
}