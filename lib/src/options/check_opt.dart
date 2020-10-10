import 'package:flutter/material.dart';

import 'package:covid19/src/utils/styles_options.dart';

class CheckOption extends StatefulWidget {
  final String title;
  final String description;

  const CheckOption({this.title, this.description});

  @override
  _CheckOptionState createState() => _CheckOptionState();
}

class _CheckOptionState extends State<CheckOption> {
  bool check = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
        check = newValue;
      });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: Checkbox(
          value: check,
          onChanged: _onRememberMeChanged,
        ),
        title: Text(
          widget.title,
          style: title_style,
        ),
        subtitle: Text(
          widget.description,
          style: description_style,
        ),
      ),
      Divider(),
    ]);
  }
}
