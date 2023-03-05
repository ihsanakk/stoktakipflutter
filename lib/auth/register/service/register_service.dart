import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stoktakip/auth/register/model/register_request_model.dart';
import 'package:stoktakip/auth/register/model/register_response_model.dart';

abstract class IRegisterService {
  final String path = '/api/auth/register';
  final Dio dio;
  const IRegisterService(this.dio);

  Future<RegisterResponse?> register(RegisterRequest registerRequest);
}

class RegisterService extends IRegisterService {
  RegisterService(Dio dio) : super(dio);

  @override
  Future<RegisterResponse?> register(RegisterRequest registerRequest) async {
    try {
      final response = await dio.post(path, data: registerRequest);
      if (response.statusCode == HttpStatus.ok) {
        return RegisterResponse.fromJson(response.data);
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
