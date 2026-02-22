import 'package:flutter/material.dart';

import 'package:covid19/src/models/answer.dart';
import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/options/answer_expansible.dart';
import 'package:covid19/src/utils/widgets.dart';

class AnswersPage extends StatefulWidget {
  @override
  _AnswersPageState createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
  Future<List<Answer>>? _answersFetched;
  List<Answer> _answers = [];

  @override
  void initState() {
    super.initState();
    _answersFetched = profileProvider.getAnswers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _createAnswerList(),
    );
  }

  Widget _createAnswerList() {
    return FutureBuilder<List<Answer>>(
      future: _answersFetched,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return createCircularProgressIndicator();
        } else if (snapshot.hasData) {
          _answers = snapshot.data ?? [];
          return AnswerExpansible(answers: _answers);
        } else {
          return Container();
        }
      },
    );
  }
}
