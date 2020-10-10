import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/models/status.dart';
import 'package:flutter/material.dart';

import 'package:covid19/src/models/account.dart';
import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/models/role.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Account account = Account(
      id: 0,
      email: '',
      person: Person(
          id: 0,
          document: '',
          name: '',
          lastname: '',
          phone: '',
          sex: 'MASCULINO',
          location: Location(id: 0, latitude: 0.0, longitude: 0.0),
          status: Status(id: 0, name: '')),
      role: Role(id: 0, name: ''));

  List<String> _sexs = ['MASCULINO', 'FENEMINO'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs de texto'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearInput('Número de Documento', 'Documento', setDocument,
              Icons.accessibility, Icons.person_pin),
          Divider(),
          _crearInput('Nombres', 'Nombres', setName, Icons.accessibility,
              Icons.account_circle),
          Divider(),
          _crearInput('Apellidos', 'Apellidos', setLastname,
              Icons.accessibility, Icons.account_circle),
          Divider(),
          _crearInput(
              'Email', 'Email', setEmail, Icons.alternate_email, Icons.email),
          Divider(),
          _crearInput('Teléfono', 'Teléfono', setphone, Icons.share_sharp,
              Icons.phone_android_outlined),
          Divider(),
          _crearDropdown(),
        ],
      ),
    );
  }

  Widget _crearInput(String hintText, String labelText, Function onChange,
      IconData suffixIcon, IconData iconData) {
    return TextField(
        // autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            suffixIcon: Icon(suffixIcon),
            icon: Icon(iconData)));
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> list = new List();
    _sexs.forEach((sex) {
      list.add(DropdownMenuItem(
        child: Text(sex),
        value: sex,
      ));
    });

    return list;
  }

  Widget _crearDropdown() {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: account.person.sex,
            items: getOpcionesDropdown(),
            onChanged: setSex,
          ),
        )
      ],
    );
  }

  setDocument(String document) {
    setState(() => account.person.document = document);
  }

  setName(String name) {
    setState(() => account.person.name = name);
  }

  setLastname(String lastname) {
    setState(() => account.person.lastname = lastname);
  }

  setEmail(String email) {
    setState(() => account.email = email);
  }

  setphone(String phone) {
    setState(() => account.person.phone = phone);
  }

  setSex(sex) {
    setState(() => account.person.sex = sex);
  }
}
