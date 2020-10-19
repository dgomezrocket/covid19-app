import 'package:flutter/material.dart';

import 'package:covid19/src/utils/styles_options.dart';

class CheckOption extends StatefulWidget {
  String title;
  String description;
  bool value;

  CheckOption({this.title, this.description, this.value});

  @override
  _CheckOptionState createState() => _CheckOptionState();
}

class _CheckOptionState extends State<CheckOption> {
  void _onRememberMeChanged(bool newValue) => setState(() {
        widget.value = newValue;
      });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: Checkbox(
          value: widget.value,
          onChanged: _onRememberMeChanged,
        ),
        title: Text(
          widget.title,
          style: title_style,
          locale: localES,
        ),
        subtitle: Text(
          widget.description,
          style: description_style,
          locale: localES,
        ),
      ),
      Divider(),
    ]);
  }
}
