import 'asbtract_response.dart';

class RegisterResponse extends AbstractResponse {
  String? message;

  RegisterResponse(this.message);

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
