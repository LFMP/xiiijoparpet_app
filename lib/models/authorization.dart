import 'package:joparpet_app/models/api_response.dart';

class AuthRequest {
  final String username;
  final String password;

  AuthRequest({this.username, this.password});

  bool get emailValid =>
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(username);

  Map<String, dynamic> toJson() => {
        emailValid ? "email" : "username": username == null ? null : username,
        "password": password == null ? null : password,
      };
}

class AuthResponse extends APIResponse {
  final String token;
  final String userId;
  final String realm;

  bool get isSucessfull => statusCode == 200;
  bool get hasPermission => realm == "Petiano" || realm == "Ajudante";

  AuthResponse({
    statusCode,
    this.token,
    this.userId,
    this.realm,
  }) : super(statusCode: statusCode);

  factory AuthResponse.fromJson(Map<String, dynamic> json) => json == null
      ? AuthResponse()
      : AuthResponse(
          token: json["id"] == null ? null : json["id"],
          userId: json["userId"] == null ? null : json["userId"],
          realm: json["user"]["realm"] == null ? null : json["user"]["realm"],
        );

  Map<String, dynamic> toJson() => {
        "id": token == null ? null : token,
        "userId": userId == null ? null : userId,
        "realm": realm == null ? null : realm,
      };
}
