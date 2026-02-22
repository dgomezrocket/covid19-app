import 'package:flutter/material.dart';

import 'package:covid19/src/utils/styles_options.dart';

class InputOption extends StatefulWidget {
  String value;
  String placeHolder;

  InputOption({this.placeHolder = '', this.value = ''});

  @override
  _InputOptionState createState() => _InputOptionState();
}

class _InputOptionState extends State<InputOption> {
  void _setData(String newValue) => setState(() {
        widget.value = newValue;
      });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        style: title_style,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: widget.placeHolder,
        ),
        onChanged: _setData,
      ),
      Divider(),
    ]);
  }
}
