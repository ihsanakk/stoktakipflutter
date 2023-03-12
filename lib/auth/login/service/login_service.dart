import 'package:dio/dio.dart';

import '../../../shared/enumLabel/label_names_enum.dart';
import '../model/asbtract_response.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';
import '../model/message_response.dart';
import '../model/unauthorized_response.dart';

abstract class ILoginService {
  final String path = '/api/auth/login';
  final Dio dio;
  const ILoginService(this.dio);

  Future<AbstractResponse?> login(LoginRequest loginRequest);
}

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  @override
  Future<AbstractResponse?> login(LoginRequest loginRequest) async {
    try {
      final response = await dio.post(path, data: loginRequest);
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
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
