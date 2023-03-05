class RegisterResponse {
  String? message;

  RegisterResponse(this.message);

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
