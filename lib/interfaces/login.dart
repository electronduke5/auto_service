import 'package:auto_service/models/user.dart';
import 'package:dio/dio.dart';

import '../models/login_model.dart';

abstract class ILogin{
  Future<UserModel?> login2 (String login, String password) async {
    const api = 'http://127.0.0.1:8000/api/login';

    final data = LoginModel(login, password).toJson();
    final dio = Dio();

    var response = await dio.post(api, data: data);

    if(response.statusCode == 200){
      final body = response.data;
      return UserModel.fromJson(body);
    }
    else{
      return null;
    }
  }
}