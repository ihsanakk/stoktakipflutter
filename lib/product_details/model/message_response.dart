import 'abstract_response.dart';

class MessageResponse extends AbstractResponse {
  String? message;

  MessageResponse(this.message);

  MessageResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
