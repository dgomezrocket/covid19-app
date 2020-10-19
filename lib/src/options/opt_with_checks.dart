import 'package:flutter/material.dart';

import 'package:covid19/src/options/check_opt.dart';

class ItemWithOption extends StatefulWidget {
  String title;
  String description;
  bool check;
  List<Widget> options;

  ItemWithOption({this.title, this.description, this.check, this.options});

  @override
  _ItemWithOptionState createState() => _ItemWithOptionState();
}

class _ItemWithOptionState extends State<ItemWithOption> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: ExpansionTile(
          title: CheckOption(
            title: widget.title,
            description: widget.description,
            value: widget.check,
          ),
          children: widget.options,
        ),
      ),
      Divider(),
    ]);
  }
}
