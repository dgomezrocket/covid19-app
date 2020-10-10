import 'package:flutter/material.dart';

import 'package:covid19/src/utils/styles_options.dart';

class InputOption extends StatefulWidget {
  final String placeHolder;

  const InputOption({this.placeHolder});

  @override
  _InputOptionState createState() => _InputOptionState();
}

class _InputOptionState extends State<InputOption> {
  String data = '';

  void _setData(String newValue) => setState(() {
        data = newValue;
      });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        style: title_style,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: widget.placeHolder,
          suffixIcon: Icon(Icons.playlist_add),
          icon: Icon(Icons.read_more),
        ),
        onChanged: _setData,
      ),
      Divider(),
    ]);
  }
}
