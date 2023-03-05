class MessageResponse {
  String? message;

  MessageResponse(this.message);

  MessageResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
