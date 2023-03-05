import 'dart:io';

import 'package:dio/dio.dart';

import '../model/login_request.dart';
import '../model/login_response.dart';

abstract class ILoginService {
  final String path = '/api/auth/login';
  final Dio dio;
  const ILoginService(this.dio);

  Future<LoginResponse?> login(LoginRequest loginRequest);
}

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  @override
  Future<LoginResponse?> login(LoginRequest loginRequest) async {
    try {
      final response = await dio.post(path, data: loginRequest);
      if (response.statusCode == HttpStatus.ok) {
        return LoginResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        if (e.response!.statusCode == 401) {}
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
    return null;
  }
}
