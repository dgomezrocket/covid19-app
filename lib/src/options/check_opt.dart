import 'package:flutter/material.dart';

import 'package:covid19/src/models/item.dart';
import 'package:covid19/src/utils/styles_options.dart';

class CheckOption extends StatefulWidget {
  Item item;
  bool value;

  CheckOption({this.item, this.value});

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
          widget.item.title,
          style: title_style,
          locale: localES,
        ),
        subtitle: Text(
          widget.item.subtitle,
          style: description_style,
          locale: localES,
        ),
        onTap: () => _onRememberMeChanged(!widget.value),
      ),
      Divider(),
    ]);
  }
}
