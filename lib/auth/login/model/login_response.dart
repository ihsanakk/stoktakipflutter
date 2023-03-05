class LoginResponse {
  String? email;
  String? token;

  LoginResponse(this.email, this.token);

  LoginResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    token = json['token'];
  }
}
