import 'asbtract_response.dart';

class UnauthorizedResponse extends AbstractResponse {
  String? message;

  UnauthorizedResponse(this.message);

  UnauthorizedResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
