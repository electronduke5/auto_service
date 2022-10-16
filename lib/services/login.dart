import 'package:auto_service/interfaces/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/login_model.dart';
import '../models/user.dart';

class LoginService extends ILogin {
  Future<UserModel?> login(String login, String password) async {
    const api = 'http://127.0.0.1:8000/api/login';

    final data = LoginModel(login, password).toJson();
    final dio = Dio();

    final response = await dio.post(api,
        data: data,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));

    debugPrint("Status code: ${response.statusCode}");
    debugPrint("Body: ${response.data}");

    if (response.statusCode == 200) {
      final body = response.data['data'];
      return UserModel.fromJson(body);
    } else if (response.statusCode == 401) {
      throw Exception(response.data['message']);
    } else {
      throw Exception('=[');
    }
  }
}
