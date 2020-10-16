import 'package:flutter/services.dart' show rootBundle;

import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/services/auth_service.dart';
import 'package:covid19/src/utils/config.dart';
import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/models/status.dart';

class _ProfileProvider {
  _getPerson(Map personMap) {
    Location location = Location(
        id: personMap['location']['id'],
        latitude: personMap['location']['latitude'],
        longitude: personMap['location']['longitude']);
    Status status = Status(
        id: personMap['status']['id'], name: personMap['status']['name']);
    Person profile =
        Person(id: personMap['id'], location: location, status: status);
    profile.document = personMap['document'];
    profile.name = personMap['name'];
    profile.lastname = personMap['lastname'];
    profile.phone = personMap['phone'];
    profile.sex = personMap['sex'];
    return profile;
  }

  Future<Person> loadPersonData() async {
    final String token = await AuthService.getTokenJwt();
    final resp = await http.get(
      '$baseUrl/persons/my',
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    return _getPerson(json.decode(resp?.body));
  }
}

final profileProvider = new _ProfileProvider();
