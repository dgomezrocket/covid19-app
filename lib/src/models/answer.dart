import 'dart:convert';

import 'package:covid19/src/models/form.dart';
import 'package:covid19/src/models/items_answer.dart';

class Answer {
  int? id;
  FormPerson form;
  DateTime? answerDate;
  List<ItemsAnswer> answers;

  Answer({this.id, required this.form, this.answerDate, required this.answers});

  factory Answer.fromJson(dynamic json) {
    List<ItemsAnswer> answers = [];
    if (json['answers'] != null) {
      var answersObjsJson = json['answers'] as List;
      answers = answersObjsJson
          .map((answer) => ItemsAnswer.fromJson(answer))
          .toList();
    }

    return Answer(
        id: json['id'] as int?,
        form: FormPerson.fromJson(json['form']),
        answerDate: json['answerDate'] == null
            ? null
            : DateTime.parse(json['answerDate'].toString()),
        answers: answers);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'form': form.toJson(),
        'answerDate': answerDate?.toIso8601String(),
        'answers': answers.map((answer) => answer.toJson()).toList()
      };

  @override
  String toString() {
    return '{ $id, $form, $answerDate, $answers }';
  }
}
