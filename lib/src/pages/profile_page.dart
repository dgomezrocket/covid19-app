import 'package:flutter/material.dart';

import 'package:covid19/src/models/account.dart';
import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/models/role.dart';
import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/models/status.dart';
import 'package:covid19/src/providers/profile_provider.dart';

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
          sex: '',
          location: Location(id: 0, latitude: 0.0, longitude: 0.0),
          status: Status(id: 0, name: '')),
      role: Role(id: 0, name: ''));

  List<String> _sexs = ['MASCULINO', 'FENEMINO'];

  // controllers for form text controllers
  TextEditingController _documentController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  @override
  void initState() {
    _documentController.text = '';
    _nameController.text = '';
    _lastnameController.text = '';
    _phoneController.text = '';
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadProfile(),
    );
  }

  Widget _loadProfile() {
    return FutureBuilder(
      future: profileProvider.loadData(),
      initialData: [],
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        _loadData(snapshot.data);

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: _createElements(),
        );
      },
    );
  }

  T _cast<T>(x) => x is T ? x : null;

  _loadData(dynamic data) {
    account.person = _cast<Person>(data);
    _documentController.text = account.person.document;
    _nameController.text = account.person.name;
    _lastnameController.text = account.person.lastname;
    _phoneController.text = account.person.phone;
  }

  List<Widget> _createElements() {
    return <Widget>[
      _createInput('Número de Documento', 'Documento', _documentController,
          setDocument, Icons.accessibility, Icons.person_pin),
      Divider(),
      _createInput('Nombres', 'Nombres', _nameController, setName,
          Icons.accessibility, Icons.account_circle),
      Divider(),
      _createInput('Apellidos', 'Apellidos', _lastnameController, setLastname,
          Icons.accessibility, Icons.account_circle),
      Divider(),
      // _createInput(
      //     'Email', 'Email', setEmail, Icons.alternate_email, Icons.email),
      // Divider(),
      _createInput('Teléfono', 'Teléfono', _phoneController, setphone,
          Icons.share_sharp, Icons.phone_android_outlined),
      Divider(),
      _createDropdown(),
    ];
  }

  Widget _createInput(
      String hintText,
      String labelText,
      TextEditingController controller,
      Function onChange,
      IconData suffixIcon,
      IconData iconData) {
    return TextField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            suffixIcon: Icon(suffixIcon),
            icon: Icon(iconData)));
  }

  List<DropdownMenuItem<String>> getOptionsDropdown() {
    List<DropdownMenuItem<String>> list = new List();
    _sexs.forEach((sex) {
      list.add(DropdownMenuItem(
        child: Text(sex),
        value: sex,
      ));
    });

    return list;
  }

  Widget _createDropdown() {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: account.person.sex,
            items: getOptionsDropdown(),
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
