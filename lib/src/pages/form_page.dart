import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:covid19/src/options/check_opt.dart';
import 'package:covid19/src/options/opt_with_checks.dart';
import 'package:covid19/src/options/item_expansible.dart';
import 'package:covid19/src/models/form.dart';
import 'package:covid19/src/models/item.dart';
import 'package:covid19/src/models/answer.dart';
import 'package:covid19/src/models/items_answer.dart';
import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/utils/styles_options.dart';
import 'package:covid19/src/utils/functions_utils.dart';
import 'package:covid19/src/utils/widgets.dart';

class FormPage extends StatefulWidget {
  final FormPerson form;
  List<Widget> items;

  FormPage({this.form});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool _load = false;
  @override
  void initState() {
    widget.items = widget.form.itemsForm.map(_createFormList).toList();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = !_load
        ? new Container()
        : new Container(
            child: new Padding(
              padding: const EdgeInsets.all(5.0),
              child: createCircularProgressIndicator(),
            ),
          );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.form.title),
      ),
      body: Stack(
        children: [
          ListView(
            children: widget.items,
          ),
          Align(
            child: loadingIndicator,
            alignment: FractionalOffset.center,
          ),
        ],
      ),
      bottomNavigationBar: _createSaveButton(context),
    );
  }

  Widget _createFormList(Item item) {
    if (item.type.toString() == 'CHECK') {
      return CheckOption(
        item: item,
        value: false,
      );
    } else if (item.type.toString() == 'INPUT_TEXT') {
      return ItemInputExpansible(
        item: item,
        value: '',
        check: false,
      );
    } else {
      //if (item.type == 'LIST')
      return ItemWithOption(
        title: item.title,
        description: item.subtitle,
        check: false,
        children: [],
      );
    }
  }

  _createSaveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton(
          child: Text('Guardar'),
          onPressed: () {
            _showAlert(context);
          },
        ),
      ],
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Row(
              children: [
                Icon(
                  Icons.save,
                  size: 30.0,
                ),
                Text('Confirmar'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '¿Está seguro de que desea guardar?',
                  locale: localES,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Guardar'),
                onPressed: () {
                  Navigator.pop(context);
                  _saveAnswer(context);
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

  Future<bool> _submitAnswer() async {
    Answer answer = Answer(
      form: widget.form,
      answerDate: DateTime.now(),
      answers: new List<ItemsAnswer>(),
    );
    widget.items.forEach((item) {
      if (cast<CheckOption>(item) != null) {
        CheckOption checkOption = cast<CheckOption>(item);
        if (checkOption.value)
          answer.answers.add(ItemsAnswer(item: checkOption.item));
      } else if (cast<ItemInputExpansible>(item) != null) {
        ItemInputExpansible itemInputExpansible =
            cast<ItemInputExpansible>(item);
        if (itemInputExpansible.check)
          answer.answers.add(ItemsAnswer(
              answerText: itemInputExpansible.value,
              item: itemInputExpansible.item));
      }
    });

    return await profileProvider.postAnswer(answer);
  }

  _saveAnswer(BuildContext context) async {
    _showCircularProgressIndicator(true);
    bool result = await _submitAnswer();
    _showCircularProgressIndicator(false);
    if (result)
      _launchAlert('Se guardaron exitosamente los datos.');
    else
      _launchAlert('Ocurrió un error al guardar los datos.');
  }

  _launchAlert(String result) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  result,
                  locale: localES,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  _showCircularProgressIndicator(bool value) {
    setState(() {
      _load = value;
    });
  }
}
