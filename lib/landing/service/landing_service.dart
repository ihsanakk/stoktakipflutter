import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stoktakip/landing/model/message_response.dart';

abstract class ILandingService {
  final String path = '/api/auth';
  final Dio dio;

  const ILandingService(this.dio);

  Future<MessageResponse?> validateToken(String token);
}

class LandingService extends ILandingService {
  LandingService(Dio dio) : super(dio);

  @override
  Future<MessageResponse?> validateToken(String token) async {
    try {
      final response =
          await dio.get('$path/validate', queryParameters: {'token': token});
      if (response.statusCode == HttpStatus.ok) {
        return MessageResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        if (e.response!.statusCode == 400) {}
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
    return null;
  }
}
