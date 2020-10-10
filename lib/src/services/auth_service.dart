import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_session/flutter_session.dart';

import 'package:covid19/src/utils/config.dart';

class AuthService {
  static final SESSION = FlutterSession();

  Future<dynamic> register(String email, String password) async {
    try {
      var res = await http.post(
        '$baseUrl/accounts/signup',
        body: jsonEncode({'email': email, 'password': password}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );

      return res?.body;
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      var res = await http.post(
        '$baseUrl/authentication/authenticate',
        body: jsonEncode({'email': email, 'password': password}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );

      return res?.body;
    } finally {
      // you can do somethig here
    }
  }

  static setToken(String token) async {
    await SESSION.set('tokenString', token);
    _AuthData data = _AuthData(token);
    await SESSION.set('token', data);
  }

  static Future<Map<String, dynamic>> getToken() async {
    return await SESSION.get('token');
  }

  static Future<String> getTokenString() async {
    return await SESSION.get('tokenString');
  }

  static removeToken() async {
    await SESSION.prefs.clear();
  }
}

class _AuthData {
  String token;
  _AuthData(this.token);

  // toJson
  // required by Session lib
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['jwt'] = token;

    return data;
  }
}
