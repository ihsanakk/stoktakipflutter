import 'package:dio/dio.dart';

class CustomDio {
  const CustomDio._();

  static const String baseUrl = "http://192.168.1.107:8080";
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    validateStatus: (status) => true,
    contentType: Headers.jsonContentType,
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
