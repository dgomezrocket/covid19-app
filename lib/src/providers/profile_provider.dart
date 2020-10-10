import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/models/status.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/services/auth_service.dart';
import 'package:covid19/src/utils/config.dart';

class _ProfileProvider {
  _getPerson(Map personMap) {
    Person profile = Person(id: 0, location: Location(), status: Status());
    profile.document = personMap['document'];
    profile.name = personMap['name'];
    profile.lastname = personMap['lastname'];
    profile.phone = personMap['phone'];
    profile.sex = personMap['sex'];
    print('GET PERSON: ');
    print(personMap);
    return profile;
  }

  Future<dynamic> loadData() async {
    final String token = await AuthService.getTokenString();
    final resp = await http.get(
      '$baseUrl/persons',
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    print(resp?.body);

    return _getPerson(json.decode(resp?.body));
  }
}

final profileProvider = new _ProfileProvider();
