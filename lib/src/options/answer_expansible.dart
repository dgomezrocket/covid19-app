import 'package:flutter/material.dart';

import 'package:covid19/src/models/answer.dart';
import 'package:covid19/src/models/items_answer.dart';
import 'package:covid19/src/utils/styles_options.dart';
import 'package:covid19/src/utils/util_constants.dart';
import 'package:intl/intl.dart';

class AnswerExpansible extends StatefulWidget {
  final List<Answer> answers;

  AnswerExpansible({required this.answers});

  @override
  _AnswerExpansibleState createState() => _AnswerExpansibleState();
}

class _AnswerExpansibleState extends State<AnswerExpansible> {
  final dateFormat = DateFormat(dateFormatWithHourString);
  late List<Widget> answersWidgets;
  late List<Widget> itemsAnsweredWidgets;

  @override
  void initState() {
    super.initState();
    answersWidgets = widget.answers.map(_createAnswer).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: answersWidgets,
    );
  }

  Widget _createAnswer(Answer answer) {
    itemsAnsweredWidgets = answer.answers.map(_createItemAnswer).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: ExpansionTile(
            title: ListTile(
              leading: Icon(Icons.question_answer_sharp),
              title: RichText(
                text: TextSpan(
                  style: title_style,
                  children: [
                    TextSpan(text: '${answer.form.title} con fecha '),
                    TextSpan(
                        text: answer.answerDate != null 
                            ? dateFormat.format(answer.answerDate!)
                            : 'Sin fecha',
                        style: title_bold_style),
                  ],
                ),
              ),
              subtitle: Text(
                answer.form.subtitle,
                style: description_style,
                locale: localES,
              ),
            ),
            children: itemsAnsweredWidgets,
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget _createItemAnswer(ItemsAnswer itemsAnswer) {
    return ListTile(
      leading: Icon(Icons.read_more),
      title: Text(
        itemsAnswer.item.title,
        style: title_style,
        locale: localES,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemsAnswer.item.subtitle,
            style: description_style,
            locale: localES,
          ),
          Text(
            'Respuesta: ${_createItemAnswerText(itemsAnswer.answerText)}',
            style: title_style,
            locale: localES,
          ),
        ],
      ),
    );
  }

  String _createItemAnswerText(String? text) {
    if (text != null) {
      return text;
    } else {
      return 'Sin respuesta';
    }
  }
}
