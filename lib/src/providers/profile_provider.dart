import 'package:flutter/services.dart' show rootBundle;

import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/services/person_service.dart';
import 'package:covid19/src/models/form.dart';
import 'package:covid19/src/models/answer.dart';

class _ProfileProvider {
  final personService = PersonService();

  Future<Person> getPerson() async {
    Map personMap = await personService.getPersonData();

    return Person.fromJson(personMap);
  }

  Future<bool> putPerson(Person person) async {
    final res = await personService.putPersonData(person);
    final data = jsonDecode(res) as Map<String, dynamic>;
    if (data['id'] != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<FormPerson>> getForms() async {
    Map formsMap = await personService.getFormsData();

    var formsObjsJson = formsMap['forms'] as List;

    List<FormPerson> forms =
        formsObjsJson.map((formJson) => FormPerson.fromJson(formJson)).toList();

    return forms;
  }

  Future<List<Answer>> getAnswers() async {
    Map answersMap = await personService.getAnswersData();

    var answersObjsJson = answersMap['answers'] as List;

    List<Answer> answers = answersObjsJson
        .map((answerJson) => Answer.fromJson(answerJson))
        .toList();

    return answers;
  }

  Future<bool> postAnswer(Answer answer) async {
    final res = await personService.postAnswersData(answer);
    final data = jsonDecode(res) as Map<String, dynamic>;
    if (data['status'] == null) {
      return true;
    } else {
      return false;
    }
  }
}

final profileProvider = new _ProfileProvider();
