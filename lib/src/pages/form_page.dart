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
  List<Widget>? items;

  FormPage({required this.form});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool _load = false;
  Widget? loadingIndicator;

  @override
  void initState() {
    super.initState();
    widget.items = widget.form.itemsForm.map(_createFormList).toList();
  }

  @override
  Widget build(BuildContext context) {
    loadingIndicator = !_load ? Container() : createLoader();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.form.title),
      ),
      body: Stack(
        children: [
          ListView(
            children: widget.items ?? [],
          ),
          Align(
            alignment: FractionalOffset.center,
            child: loadingIndicator,
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

  Widget _createSaveButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            _showConfirmation(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.save),
              SizedBox(width: 8),
              Text('Guardar', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmation(BuildContext context) {
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
              TextButton(
                child: Text('Guardar'),
                onPressed: () {
                  Navigator.pop(context);
                  _saveAnswer(context);
                },
              ),
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  Future<void> _saveAnswer(BuildContext context) async {
    _showCircularProgressIndicator(true);
    bool result = await _getAnswer();
    _showCircularProgressIndicator(false);
    if (result) {
      _launchAlert('Se guardaron exitosamente los datos.');
    } else {
      _launchAlert('Ocurrió un error al guardar los datos.');
    }
  }

  Future<bool> _getAnswer() async {
    Answer answer = Answer(
      form: widget.form,
      answerDate: DateTime.now(),
      answers: <ItemsAnswer>[],
    );
    widget.items?.forEach((item) {
      CheckOption? checkOption = cast<CheckOption>(item);
      ItemInputExpansible? itemInputExpansible = cast<ItemInputExpansible>(item);

      if (checkOption != null && checkOption.value) {
        answer.answers.add(ItemsAnswer(
            answerText: 'Sí', // Texto que indica que fue seleccionado
            item: checkOption.item));
      } else if (itemInputExpansible != null && itemInputExpansible.check) {
        answer.answers.add(ItemsAnswer(
            answerText: itemInputExpansible.value,
            item: itemInputExpansible.item));
      }
    });

    return await profileProvider.postAnswer(answer);
  }

  void _launchAlert(String result) {
    showDialog(
        context: context,
        barrierDismissible: false,
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
              TextButton(
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

  void _showCircularProgressIndicator(bool value) {
    setState(() {
      _load = value;
    });
  }
}
