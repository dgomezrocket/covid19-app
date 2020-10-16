import 'package:flutter/material.dart';

import 'package:covid19/src/models/account.dart';
import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/models/role.dart';
import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/models/status.dart';
import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/utils/widgets.dart';
import 'package:covid19/src/utils/util_classes.dart';
import 'package:covid19/src/utils/functions_utils.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Person> _personFetched;
  Account _account = Account(
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

  // controllers for form text controllers
  PhoneEditingController _documentController = new PhoneEditingController();
  PhoneEditingController _nameController = new PhoneEditingController();
  PhoneEditingController _lastnameController = new PhoneEditingController();
  PhoneEditingController _phoneController = new PhoneEditingController();

  @override
  void initState() {
    _personFetched = profileProvider.getPerson();
    _documentController.text = '';
    _nameController.text = '';
    _lastnameController.text = '';
    _phoneController.text = '';
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _loadProfile(context),
    );
  }

  _loadProfile(BuildContext context) {
    return FutureBuilder(
      future: _personFetched,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return createCircularProgressIndicator();
        } else {
          _loadData(snapshot.data);

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: _createElements(),
          );
        }
      },
    );
  }

  _loadData(dynamic data) {
    if (data != null) {
      _account.person = cast<Person>(data);
      _documentController.text = _account.person.document;
      _nameController.text = _account.person.name;
      _lastnameController.text = _account.person.lastname;
      _phoneController.text = _account.person.phone;
    }
  }

  List<Widget> _createElements() {
    return <Widget>[
      _createInput('Número de Documento', 'Documento', _documentController,
          _setDocument, Icons.accessibility, Icons.person_pin),
      Divider(),
      _createInput('Nombres', 'Nombres', _nameController, _setName,
          Icons.accessibility, Icons.account_circle),
      Divider(),
      _createInput('Apellidos', 'Apellidos', _lastnameController, _setLastname,
          Icons.accessibility, Icons.account_circle),
      Divider(),
      // _createInput(
      //     'Email', 'Email', setEmail, Icons.alternate_email, Icons.email),
      // Divider(),
      _createInput('Teléfono', 'Teléfono', _phoneController, _setphone,
          Icons.share_sharp, Icons.phone_android_outlined),
      Divider(),
      _createDropdown(),
    ];
  }

  Widget _createInput(
      String hintText,
      String labelText,
      TextEditingController controller,
      Function onChangeFunction,
      IconData suffixIcon,
      IconData iconData) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          counter: Text('${controller.text.length}'),
          hintText: hintText,
          labelText: labelText,
          suffixIcon: Icon(suffixIcon),
          icon: Icon(iconData)),
      onChanged: onChangeFunction,
    );
  }

  List<DropdownMenuItem<String>> _getOptionsDropdown() {
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
            value: _account.person.sex,
            items: _getOptionsDropdown(),
            onChanged: _setSex,
          ),
        )
      ],
    );
  }

  _setDocument(document) {
    setState(() => _account.person.document = document);
  }

  _setName(name) {
    setState(() => _account.person.name = name);
  }

  _setLastname(lastname) {
    setState(() => _account.person.lastname = lastname);
  }

  _setEmail(email) {
    setState(() => _account.email = email);
  }

  _setphone(phone) {
    setState(() => _account.person.phone = phone);
  }

  _setSex(sex) {
    setState(() => _account.person.sex = sex);
  }
}
