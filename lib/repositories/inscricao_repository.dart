import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart'; // For debug only
// Foreign
import 'package:http/http.dart' as http;
// Repositories
import 'package:joparpet_app/repositories/repository.dart';
// Models
import 'package:joparpet_app/models/api_response.dart';
import 'package:joparpet_app/models/inscricao.dart';

class InscricaoRepository extends Repository{
  
  static Future<APIResponse> fetchEvents({
    @required int atividadeId,
    @required int turmaId,
    @required String token
  }) async{
     try{
      final response = await http.get(
        Repository.API_INSCRICOES
        .replaceFirst('\$', turmaId.toString())
        .replaceFirst('\$', atividadeId.toString()),
        headers: {HttpHeaders.authorizationHeader: token},
      );

      final body = json.decode(response?.body) ?? null;

      if (response.statusCode == 200) {
        final result = ListInscricaoModel.fromJson(body);
        result.setStatusCode = response.statusCode;
        print('[Fetch Inscricao from API]');
        return result;
      }else{
        print('[Fetch Inscricao Failed]');
        return APIError.fromJson(body);
      }
    }catch(e){
      print(e);
      debugPrintStack();
      return APIError(message: e.toString());      
    }
  }

}