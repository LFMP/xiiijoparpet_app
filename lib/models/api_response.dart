class APIResponse{
  int statusCode;

  APIResponse({this.statusCode});

  set setStatusCode(int _statusCode) => statusCode = _statusCode;

  bool get isSucessfull => statusCode == 200;
}

class APIError extends APIResponse{
    int statusCode;
    String name;
    String message;
    String code;   

    APIError({
        this.statusCode,
        this.name,
        this.message,
        this.code,
    }) : super(statusCode: statusCode);

    @override
    bool get isSucessfull => false;

    factory APIError.fromJson(Map<String, dynamic> json){
      if (json == null || json ["error"] == null)
        return null;
      json = json['error'];
      return APIError(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        name: json["name"] == null ? null : json["name"],
        message: json["message"] == null ? null : json["message"],
        code: json["code"] == null ? null : json["code"],
      );
    }

    Map<String, dynamic> toJson() => {
      "error": {
        "statusCode": statusCode == null ? null : statusCode,
        "name": name == null ? null : name,
        "message": message == null ? null : message,
        "code": code == null ? null : code,
      }
    };
}