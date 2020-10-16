import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid19/src/utils/config.dart';
import 'package:covid19/src/services/auth_service.dart';

class PersonService {
  Future<dynamic> _getPersonBasedOnJwt() async {
    try {
      final String token = await AuthService.getTokenJwt();
      var res = await http.post(
        '$baseUrl/forms/',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      return res?.body;
    } finally {
      // done you can do something here
    }
  }

  // _getForms(Map formsMap) {
  //   Location location = Location(
  //       id: personMap['location']['id'],
  //       latitude: personMap['location']['latitude'],
  //       longitude: personMap['location']['longitude']);
  //   Status status = Status(
  //       id: personMap['status']['id'], name: personMap['status']['name']);
  //   Person profile =
  //       Person(id: personMap['id'], location: location, status: status);
  //   profile.document = personMap['document'];
  //   profile.name = personMap['name'];
  //   profile.lastname = personMap['lastname'];
  //   profile.phone = personMap['phone'];
  //   profile.sex = personMap['sex'];
  //   return profile;
  // }
}
