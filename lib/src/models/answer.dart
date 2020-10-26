import 'dart:convert';

import 'package:covid19/src/models/form.dart';
import 'package:covid19/src/models/items_answer.dart';

class Answer {
  int id;
  FormPerson form;
  DateTime answerDate;
  List<ItemsAnswer> answers;

  Answer({this.id, this.form, this.answerDate, this.answers});

  factory Answer.fromJson(dynamic json) {
    if (json['answers'] != null) {
      var answersObjsJson = json['answers'] as List;

      List<ItemsAnswer> _answers = answersObjsJson
          .map((answer) => ItemsAnswer.fromJson(answer))
          .toList();

      return Answer(
          id: json['id'] as int,
          form: FormPerson.fromJson(json['form']),
          answerDate: json['answerDate'] == null
              ? null
              : DateTime.parse(json['answerDate'].toString()),
          answers: _answers);
    } else
      return Answer(
          id: json['id'] as int,
          form: FormPerson.fromJson(json['form']),
          answerDate: json['answerDate'] == null
              ? null
              : DateTime.parse(json['answerDate'].toString()));
  }

  Map<String, dynamic> toJson() {
    if (this.answers != null)
      return {
        'id': id,
        'form': form.toJson(),
        'answerDate': answerDate == null ? null : answerDate.toIso8601String(),
        'answers': answers.map((answer) => answer.toJson()).toList()
      };
    else
      return {
        'id': id,
        'form': form.toJson(),
        'answerDate': answerDate == null ? null : answerDate.toIso8601String()
      };
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.form}, ${this.answerDate}, ${this.answers} }';
  }
}
