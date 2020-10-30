import 'package:flutter/material.dart';

import 'package:covid19/src/models/answer.dart';
import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/options/answer_expansible.dart';
import 'package:covid19/src/utils/functions_utils.dart';
import 'package:covid19/src/utils/widgets.dart';

class AnswersPage extends StatefulWidget {
  @override
  _AnswersPageState createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
  Future<List<Answer>> _answersFetched;

  List<Answer> _answers = List();

  @override
  void initState() {
    _answersFetched = profileProvider.getAnswers();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _createAnswerList(),
    );
  }

  _createAnswerList() {
    return FutureBuilder(
      future: _answersFetched,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return createCircularProgressIndicator();
        } else if (snapshot.hasData) {
          _loadData(snapshot.data);

          return AnswerExpansible(answers: _answers);
        } else
          return Container();
      },
    );
  }

  _loadData(dynamic data) {
    if (data != null) _answers = cast<List<Answer>>(data);
  }
}
