import 'package:flutter/material.dart';

import 'package:covid19/src/models/form.dart';
import 'package:covid19/src/pages/form_page.dart';

class FormItem extends StatefulWidget {
  final FormPerson form;

  const FormItem({this.form});

  @override
  _FormItemState createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(widget.form.title),
        subtitle: Text(widget.form.subtitle),
        leading: Icon(Icons.read_more),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          final route = MaterialPageRoute(
              builder: (context) => FormPage(
                    form: widget.form,
                  ));
          Navigator.push(context, route);
        },
      ),
      Divider(),
    ]);
  }
}
