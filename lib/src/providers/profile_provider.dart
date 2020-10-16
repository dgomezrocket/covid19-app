import 'package:flutter/services.dart' show rootBundle;

import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/services/person_service.dart';
import 'package:covid19/src/models/form.dart';

class _ProfileProvider {
  final personService = PersonService();

  Future<Person> getPerson() async {
    Map personMap = await personService.loadPersonData();

    return Person.fromJson(personMap);
  }

  Future<List<FormPerson>> getForms() async {
    Map formsMap = await personService.getFormsData();

    var formsObjsJson = formsMap['forms'] as List;

    List<FormPerson> forms =
        formsObjsJson.map((formJson) => FormPerson.fromJson(formJson)).toList();

    return forms;
  }
}

final profileProvider = new _ProfileProvider();
