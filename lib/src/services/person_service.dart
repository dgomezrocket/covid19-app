import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid19/src/utils/config.dart';
import 'package:covid19/src/services/auth_service.dart';

class PersonService {
  Future<dynamic> loadPersonData() async {
    try {
      final String token = await AuthService.getTokenJwt();
      final resp = await http.get(
        '$baseUrl/persons/my',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      return json.decode(resp?.body);
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> getFormsData() async {
    try {
      final String token = await AuthService.getTokenJwt();
      var res = await http.get(
        '$baseUrl/forms/',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      return json.decode(res?.body);
    } finally {
      // done you can do something here
    }
  }
}
