import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart'; // For debug only
// Foreign
import 'package:http/http.dart' as http;
// Repositories
import 'package:joparpet_app/repositories/repository.dart';
// Models
import 'package:joparpet_app/models/api_response.dart';
import 'package:joparpet_app/models/presenca.dart';

class PresencaRepository extends Repository{
  
  static Future<APIResponse> setPresenca(
    PresencaModel presenca,
    String token
  ) async{
     try{
      final response = await http.post(
        Repository.API_PRESENCA,
        body: presenca.toJson(),
        headers: {HttpHeaders.authorizationHeader: token},
      );

      final body = json.decode(response?.body) ?? null;
      final result = PresencaModel.fromJson(body);
      result.setStatusCode = response.statusCode;

      if (response.statusCode == 200) {
        print('[Presença sucessfull]');
        return result;
      }else{
        print('[Presença failed]');
        return APIError.fromJson(body);
      }

    }catch(e){
      print(e);
      debugPrintStack();
      return APIError(message: e.toString());
    }
  }

}