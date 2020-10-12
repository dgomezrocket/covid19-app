import 'package:flutter/material.dart';

import 'package:covid19/src/options/check_opt.dart';
import 'package:covid19/src/options/opt_with_checks.dart';
import 'package:covid19/src/options/choice_opt.dart';
import 'package:covid19/src/options/input_text_opt.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _createFormList(),
      ),
    );
  }

  _createFormList() {
    return ListView(
      children: [
        CheckOption(
          title: 'Elemento de un formulario 1',
          description: 'Descripcion del elemento, esto puede ser largo',
        ),
        CheckOption(
          title: 'Elemento de un formulario 2',
          description: 'Descripcion del elemento, esto puede ser largo',
        ),
        ItemWithOption(
          title: 'Elemento de un formulario 3',
          description: 'Descripcion del elemento, esto puede ser largo',
          options: [
            CheckOption(
              title: 'Elemento de un formulario 1',
              description: 'Descripcion del elemento, esto puede ser largo',
            ),
            CheckOption(
              title: 'Elemento de un formulario 2',
              description: 'Descripcion del elemento, esto puede ser largo',
            ),
          ],
        ),
        ItemWithOption(
          title: 'Elemento de un formulario 3',
          description: 'Descripcion del elemento, esto puede ser largo',
          options: [
            ChoiceOption(children: [
              ChoiceItem(
                title: 'Elemento de un formulario 1',
                description: 'Descripcion del elemento, esto puede ser largo',
                choiceValue: 0,
              ),
              ChoiceItem(
                title: 'Elemento de un formulario 1',
                description: 'Descripcion del elemento, esto puede ser largo',
                choiceValue: 1,
              ),
              ChoiceItem(
                title: 'Elemento de un formulario 1',
                description: 'Descripcion del elemento, esto puede ser largo',
                choiceValue: 2,
              ),
            ]),
          ],
        ),
        ItemWithOption(
          title: 'Elemento de un formulario 3',
          description: 'Descripcion del elemento, esto puede ser largo',
          options: [InputOption(placeHolder: 'Responda aqui...')],
        ),
        _createButtonSave(),
      ],
    );
  }

  _createButtonSave() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      FlatButton(
        child: Text('Guardar'),
        onPressed: () {},
      )
    ]);
  }
}
