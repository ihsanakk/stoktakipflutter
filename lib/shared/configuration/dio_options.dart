import 'package:dio/dio.dart';

class CustomDio {
  const CustomDio._();

  static const String baseUrl = "http://192.168.1.107:8080";
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
    receiveTimeout: const Duration(seconds: 60),
    contentType: Headers.jsonContentType,
    connectTimeout: const Duration(seconds: 60),
    responseType: ResponseType.json,
  ));
  static Dio getDio() {
    return _dio;
  }

  static Options authOptions(String? token) {
    return Options(headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
  }
}
