import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid19/src/models/answer.dart';
import 'package:covid19/src/models/message.dart';
import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/utils/config.dart';
import 'package:covid19/src/services/auth_service.dart';

class PersonService {
  Future<dynamic> getPersonData() async {
    try {
      final String token = await AuthService.getTokenJwt();
      final resp = await http.get(
        '$baseUrl/persons/my',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      return json.decode(utf8.decode(resp.bodyBytes));
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> putPersonData(Person person) async {
    try {
      final String token = await AuthService.getTokenJwt();
      final resp = await http.put(
        '$baseUrl/persons/',
        body: jsonEncode(person.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      );

      return resp?.body;
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> getFormsData() async {
    try {
      final String token = await AuthService.getTokenJwt();
      var resp = await http.get(
        '$baseUrl/forms/my',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      return json.decode(utf8.decode(resp.bodyBytes));
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> getAnswersData() async {
    try {
      final String token = await AuthService.getTokenJwt();
      var resp = await http.get(
        '$baseUrl/answers/',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      return json.decode(utf8.decode(resp.bodyBytes));
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> postAnswersData(Answer answer) async {
    try {
      final String token = await AuthService.getTokenJwt();
      var resp = await http.post(
        '$baseUrl/answers/',
        body: jsonEncode(answer.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      return resp?.body;
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> getHospitalsData() async {
    try {
      final String token = await AuthService.getTokenJwt();
      final resp = await http.get(
        '$baseUrl/hospitals/',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      return json.decode(utf8.decode(resp.bodyBytes));
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> getMessagesData() async {
    try {
      final String token = await AuthService.getTokenJwt();
      final resp = await http.get(
        '$baseUrl/messages/',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      return json.decode(utf8.decode(resp.bodyBytes));
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> postMessageData(Message message) async {
    try {
      final String token = await AuthService.getTokenJwt();
      var resp = await http.post(
        '$baseUrl/messages/',
        body: jsonEncode(message.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      return resp?.body;
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> getProvinces() async {
    try {
      final String token = await AuthService.getTokenJwt();
      var resp = await http.get(
        '$baseUrl/provinces/',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      return json.decode(utf8.decode(resp.bodyBytes));
    } finally {
      // done you can do something here
    }
  }
}
