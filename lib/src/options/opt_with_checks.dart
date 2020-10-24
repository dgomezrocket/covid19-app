import 'package:flutter/material.dart';

import 'package:covid19/src/models/item.dart';
import 'package:covid19/src/options/check_opt.dart';

class ItemWithOption extends StatefulWidget {
  String title;
  String description;
  bool check;
  List<Widget> children;

  ItemWithOption({this.title, this.description, this.check, this.children});

  @override
  _ItemWithOptionState createState() => _ItemWithOptionState();
}

// TODO: Add extension depends on check and value reachable from this scope.
class _ItemWithOptionState extends State<ItemWithOption> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: ExpansionTile(
          title: CheckOption(
            item: Item(title: widget.title, subtitle: widget.description),
            value: widget.check,
          ),
          children: widget.children,
        ),
      ),
      Divider(),
    ]);
  }
}
