import 'package:flutter/material.dart';

import 'package:covid19/src/utils/styles_options.dart';

class ChoiceItem {
  final String title;
  final String description;
  final int choiceValue;

  const ChoiceItem({this.title, this.description, this.choiceValue});
}

class ChoiceOption extends StatefulWidget {
  final List<ChoiceItem> children;

  const ChoiceOption({this.children});

  @override
  _ChoiceOptionState createState() => _ChoiceOptionState();
}

class _ChoiceOptionState extends State<ChoiceOption> {
  int _choice = 0;

  void _onRememberMeChanged(int newValue) => setState(() {
        _choice = newValue;
      });

  @override
  Widget build(BuildContext context) {
    return Column(children: widget.children.map(createRadioOption).toList());
  }

  Widget createRadioOption(ChoiceItem choiceItem) {
    return Column(children: [
      ListTile(
        leading: Radio(
          value: choiceItem.choiceValue,
          groupValue: _choice,
          onChanged: _onRememberMeChanged,
        ),
        title: Text(
          choiceItem.title,
          style: title_style,
        ),
        subtitle: Text(
          choiceItem.description,
          style: description_style,
        ),
      ),
      Divider(),
    ]);
  }
}
