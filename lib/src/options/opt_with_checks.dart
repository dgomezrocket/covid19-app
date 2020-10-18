import 'package:flutter/material.dart';

import 'package:covid19/src/utils/styles_options.dart';

class ItemWithOption extends StatefulWidget {
  final String title;
  final String description;
  final List<Widget> options;

  const ItemWithOption({this.title, this.description, this.options});

  @override
  _ItemWithOptionState createState() => _ItemWithOptionState();
}

class _ItemWithOptionState extends State<ItemWithOption> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: ExpansionTile(
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
          children: widget.options,
        ),
      ),
      Divider(),
    ]);
  }
}
