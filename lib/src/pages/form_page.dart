import 'dart:html';

import 'package:flutter/material.dart';

import 'package:covid19/src/options/check_opt.dart';
import 'package:covid19/src/options/opt_with_checks.dart';
import 'package:covid19/src/options/choice_opt.dart';
import 'package:covid19/src/options/input_text_opt.dart';
import 'package:covid19/src/models/form.dart';
import 'package:covid19/src/models/item.dart';
import 'package:covid19/src/utils/styles_options.dart';

class FormPage extends StatefulWidget {
  final FormPerson form;

  const FormPage({this.form});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.form.title),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: widget.form.itemsForm.map(_createFormList).toList(),
      ),
      bottomNavigationBar: _createButtonSave(context),
    );
  }

  Widget _createFormList(Item item) {
    if (item.type.toString() == 'CHECK')
      return CheckOption(
        title: item.title,
        description: item.subtitle,
      );
    else if (item.type.toString() == 'INPUT_TEXT')
      return ItemWithOption(
        title: item.title,
        description: item.subtitle,
        options: [InputOption(placeHolder: 'Responda aqui...')],
      );
    else //if (item.type == 'LIST')
      return ItemWithOption(
        title: item.title,
        description: item.subtitle,
        options: [],
      );
  }

  _createButtonSave(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton(
          child: Text('Guardar'),
          onPressed: () {
            _mostrarAlert(context);
          },
        ),
      ],
    );
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Confirmar'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '¿Está seguro de que desea guardar?',
                  locale: localES,
                ),
                Icon(
                  Icons.save,
                  size: 50.0,
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Guardar'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
}
