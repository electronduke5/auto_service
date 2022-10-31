import 'dart:convert';

import 'package:auto_service/domain/repositories/login_repository.dart';
import 'package:auto_service/interfaces/login.dart';
import 'package:auto_service/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/dto/employee_dto.dart';
import '../domain/models/login_model.dart';

class LoginService extends ApiService<EmployeeDto> {
  Future<EmployeeDto> login(String login, String password) => getEntity(
      apiRoute: 'http://127.0.0.1:8000/api/login',
      entityProducer: (Map<String, dynamic> json) => EmployeeDto.fromJson(json),
      dataJson: LoginModel(login, password).toJson());

// @override
// Future<EmployeeDto> login1(String login, String password) async {
//   const api = 'http://127.0.0.1:8000/api/login';
//
//   final data = LoginModel(login, password).toJson();
//   final dio = Dio();
//
//   final response = await dio.post(api,
//       data: data,
//       options: Options(
//           followRedirects: false,
//           validateStatus: (status) {
//             return status! < 500;
//           }));
//
//   debugPrint("Status code: ${response.statusCode}");
//   debugPrint("Body: ${response.data}");
//
//   if (response.statusCode == 200) {
//     final body = response.data['data'];
//     return EmployeeDto.fromJson(body);
//   } else if (response.statusCode == 401) {
//     throw Exception(response.data['message']);
//   } else {
//     throw Exception('=[');
//   }
// }
}
