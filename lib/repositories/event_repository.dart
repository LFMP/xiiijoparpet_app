import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart'; // For debug only
// Foreign
import 'package:http/http.dart' as http;
// Repositories
import 'package:joparpet_app/repositories/repository.dart';
// Models
import 'package:joparpet_app/models/api_response.dart';
import 'package:joparpet_app/models/evento.dart';

class EventRepository extends Repository{
  
  static Future<APIResponse> fetchEvents(String token) async{
     try{
      final response = await http.get(
        Repository.API_EVENTOS,
        headers: {HttpHeaders.authorizationHeader: token},
      );

      final body = json.decode(response?.body) ?? null;

      if (response.statusCode == 200) {
        final result = ListEventoModel.fromJson(body);
        result.setStatusCode = response.statusCode;
        print('[Fetch Event from API]');
        return result;
      }else{
        print('[Fetch Event Failed]');
        return APIError.fromJson(body);
      }
    }catch(e){
      print(e);
      debugPrintStack();
      return APIError(message: e.toString());      
    }
  }

}