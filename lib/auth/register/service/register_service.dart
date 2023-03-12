import 'package:dio/dio.dart';
import 'package:stoktakip/auth/register/model/register_request_model.dart';
import 'package:stoktakip/auth/register/model/register_response_model.dart';

import '../../../shared/enumLabel/label_names_enum.dart';
import '../model/asbtract_response.dart';
import '../model/message_response.dart';
import '../model/unauthorized_response.dart';

abstract class IRegisterService {
  final String path = '/api/auth/register';
  final Dio dio;
  const IRegisterService(this.dio);

  Future<AbstractResponse?> register(RegisterRequest registerRequest);
}

class RegisterService extends IRegisterService {
  RegisterService(Dio dio) : super(dio);

  @override
  Future<AbstractResponse?> register(RegisterRequest registerRequest) async {
    try {
      final response = await dio.post(path, data: registerRequest);
      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(response.data);
      } else if (response.statusCode == 401) {
        return UnauthorizedResponse.fromJson(response.data);
      } else if (response.statusCode == 400) {
        return MessageResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          print(e.response!.data);
          print(e.response!.headers);
          print(e.response!.requestOptions);
          if (e.response!.statusCode == 401) {
            return UnauthorizedResponse.fromJson(e.response!.data);
          } else if (e.response!.statusCode == 400) {
            return MessageResponse.fromJson(e.response!.data);
          }
        } else {
          print(e.requestOptions);
          print(e.message);
          return MessageResponse(LabelNames.SERVICE_ERROR);
        }
      }
    }
    return null;
  }
}
