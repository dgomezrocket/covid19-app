import 'package:flutter/material.dart';

import 'package:covid19/src/models/option.dart';
import 'package:covid19/src/utils/styles_options.dart';

class ChoiceOption extends StatefulWidget {
  List<Option> children;
  int value = 0;

  ChoiceOption({this.children});

  @override
  _ChoiceOptionState createState() => _ChoiceOptionState();
}

class _ChoiceOptionState extends State<ChoiceOption> {
  void _onRememberMeChanged(int newValue) => setState(() {
        widget.value = newValue;
      });

  @override
  Widget build(BuildContext context) {
    return Column(children: widget.children.map(createRadioOption).toList());
  }

  Widget createRadioOption(Option choiceItem) {
    return Column(children: [
      ListTile(
        leading: Radio(
          value: choiceItem.id,
          groupValue: widget.value,
          onChanged: _onRememberMeChanged,
        ),
        title: Text(
          choiceItem.title,
          style: title_style,
          locale: localES,
        ),
        subtitle: Text(
          choiceItem.subtitle,
          style: description_style,
          locale: localES,
        ),
      ),
      Divider(),
    ]);
  }
}
