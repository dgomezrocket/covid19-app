import 'package:covid19/src/models/item.dart';
import 'package:flutter/material.dart';

import 'package:covid19/src/utils/styles_options.dart';

class ItemInputExpansible extends StatefulWidget {
  final Item item;
  final String placeHolder = 'Responda aqui...';
  String value;
  bool check;

  ItemInputExpansible({this.item, this.value, this.check});

  @override
  _ItemInputExpansibleState createState() => _ItemInputExpansibleState();
}

class _ItemInputExpansibleState extends State<ItemInputExpansible> {
  void _setData(String newValue) => setState(() {
        widget.value = newValue;
      });

  void _changeCheck(bool newValue) => setState(() {
        widget.check = newValue;
      });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: ExpansionTile(
          onExpansionChanged: _changeCheck,
          title: ListTile(
            leading: Checkbox(
              value: widget.check,
              onChanged: (bool value) {},
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
          ),
          children: [
            TextField(
              style: title_style,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: widget.placeHolder,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              ),
              onChanged: _setData,
            ),
          ],
        ),
      ),
      Divider(),
    ]);
  }
}
