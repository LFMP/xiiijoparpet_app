import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart'; // For debug only
// Foreign
import 'package:http/http.dart' as http;
// Repositories
import 'package:joparpet_app/repositories/repository.dart';
// Models
import 'package:joparpet_app/models/api_response.dart';
import 'package:joparpet_app/models/atividade.dart';

class AtividadeRepository extends Repository{
  
  static Future<APIResponse> fetchEvents(int eventoId, String token) async{
     try{
      final response = await http.get(
        Repository.API_ATIVIDADES.replaceFirst('\$', eventoId.toString()),
        headers: {HttpHeaders.authorizationHeader: token},
      );

      final body = json.decode(response?.body) ?? null;

      if (response.statusCode == 200) {
        final result = ListAtividadeModel.fromJson(body);
        result.setStatusCode = response.statusCode;
        print('[Fetch Atividade from API]');
        return result;
      }else{
        print('[Fetch Atividade Failed]');
        return APIError.fromJson(body);
      }
    }catch(e){
      print(e);
      debugPrintStack();
      return APIError(message: e.toString());      
    }
  }

}