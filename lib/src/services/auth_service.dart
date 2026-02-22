import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:covid19/src/utils/config.dart';

class AuthService {
  static SharedPreferences? _prefs;

  static Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<dynamic> register(String email, String password) async {
    try {
      var res = await http.post(
        Uri.parse('$baseUrl/accounts/signup'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );

      return res.body;
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      var res = await http.post(
        Uri.parse('$baseUrl/authentication/authenticate'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );

      return res.body;
    } finally {
      // you can do something here
    }
  }

  static Future<void> setToken(String token) async {
    await _initPrefs();
    await _prefs!.setString('token', token);
  }

  static Future<String?> getToken() async {
    await _initPrefs();
    return _prefs!.getString('token');
  }

  static Future<void> removeToken() async {
    await _initPrefs();
    await _prefs!.clear();
  }

  static Future<String?> getTokenJwt() async {
    await _initPrefs();
    if (_prefs!.containsKey('token')) {
      return _prefs!.getString('token');
    }
    return null;
  }
}
