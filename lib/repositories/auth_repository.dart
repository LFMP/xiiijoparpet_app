import 'dart:convert';
import 'package:flutter/cupertino.dart'; // For debug only
// Foreign
import 'package:http/http.dart' as http;
// Repositories
import 'package:joparpet_app/repositories/repository.dart';
// Models
import 'package:joparpet_app/models/authorization.dart';
import 'package:joparpet_app/models/api_response.dart';

class AuthRepository extends Repository{
  
  static Future<APIResponse> login(AuthRequest request) async{
     try{
      final response = await http.post(
        Repository.API_USUARIOS_LOGIN,
        body: request.toJson()
      );

      final body = json.decode(response?.body) ?? null;
      print(body);

      final result = AuthResponse.fromJson(body);
      result.setStatusCode = response.statusCode;

      if (response.statusCode == 200) {
        print('[Login sucessfull]');
        return result;
      }else{
        print('[Login failed]');
        return APIError.fromJson(body);
      }
    }catch(e){
      print(e);
      debugPrintStack();
      return APIError(message: e.toString());
    }
  }

}