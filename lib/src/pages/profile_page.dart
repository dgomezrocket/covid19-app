import 'package:flutter/material.dart';

import 'package:covid19/src/models/account.dart';
import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/models/role.dart';
import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/models/status.dart';
import 'package:covid19/src/models/province.dart';
import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/utils/widgets.dart';
import 'package:covid19/src/utils/util_classes.dart';
import 'package:covid19/src/utils/functions_utils.dart';
import 'package:covid19/src/utils/util_constants.dart';
import 'package:covid19/src/utils/styles_options.dart';
import 'package:covid19/src/pages/livemap_location.dart';

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Person> _personFetched;
  List<Province> _provinces;
  Account _account = Account(
      id: 0,
      email: '',
      person: Person(
          id: 0,
          document: '',
          name: '',
          lastname: '',
          birthDate: DateTime.now(),
          phone: '',
          sex: 'MASCULINO',
          address: '',
          location: null,
          status: Status(name: 'HEALTHY'),
          province: Province(name: 'Asunción')),
      role: Role(id: 0, name: ''));

  final dateFormat = DateFormat(dateFormatString);

  final _formKey = GlobalKey<FormState>();

  List<String> _sexs = ['MASCULINO', 'FEMENINO'];

  bool _load = false;
  Widget loadingIndicator;

  // controllers for form text controllers
  CustomEditingController _documentController = new CustomEditingController();
  CustomEditingController _nameController = new CustomEditingController();
  CustomEditingController _lastnameController = new CustomEditingController();
  CustomEditingController _birthDateController = new CustomEditingController();
  CustomEditingController _phoneController = new CustomEditingController();
  CustomEditingController _addressController = new CustomEditingController();

  @override
  void initState() {
    _personFetched = _loadAsynchronousData();
    _documentController.text = '';
    _nameController.text = '';
    _lastnameController.text = '';
    _birthDateController.text = '';
    _phoneController.text = '';
    _addressController.text = '';
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadingIndicator = !_load ? new Container() : createLoader();
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
          _loadPersonData(snapshot.data);

          return Stack(
            children: [
              Form(
                key: _formKey,
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  children: _createElements(),
                ),
              ),
              Align(
                child: loadingIndicator,
                alignment: FractionalOffset.center,
              ),
            ],
          );
        }
      },
    );
  }

  _loadPersonData(dynamic data) {
    if (data != null) {
      _account.person = cast<Person>(data);
      if (_account.person.province == null) {
        _account.person.province = _provinces[0];
      }
      _documentController.text = _account.person.document;
      _nameController.text = _account.person.name;
      _lastnameController.text = _account.person.lastname;
      _birthDateController.text = _account.person.birthDate == null
          ? ''
          : dateFormat.format(DateTime.now());
      _phoneController.text = _account.person.phone;
      _addressController.text = _account.person.address;
    } else {
      _account.person.province = _provinces[0];
    }
  }

  Future<Person> _loadAsynchronousData() async {
    _provinces = await profileProvider.getProvices();
    return profileProvider.getPerson();
  }

  List<Widget> _createElements() {
    return <Widget>[
      _createInput(
          'Número de Documento',
          'Documento',
          'Introduzca el documento',
          _documentController,
          _setDocument,
          _nonEmptyValidation,
          Icons.accessibility,
          Icons.person_pin),
      Divider(),
      _createInput(
          'Nombres',
          'Nombres',
          'Introduzca el/los nombre/s',
          _nameController,
          _setName,
          _nonEmptyValidation,
          Icons.accessibility,
          Icons.account_circle),
      Divider(),
      _createInput(
          'Apellidos',
          'Apellidos',
          'Introduzca el/los apellido/s',
          _lastnameController,
          _setLastname,
          _nonEmptyValidation,
          Icons.accessibility,
          Icons.account_circle),
      Divider(),
      // _createInput(
      //     'Email', 'Email', setEmail, Icons.alternate_email, Icons.email),
      // Divider(),
      _createInput(
          'Teléfono',
          'Teléfono',
          'Introduzca el teléfono',
          _phoneController,
          _setphone,
          _nonEmptyValidation,
          Icons.share_sharp,
          Icons.phone_android_outlined),
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: _createInput(
                'Dirección de domicilio',
                'Dirección',
                'Introduzca la dirección y localización',
                _addressController,
                _setAddress,
                _nonEmptyAddress,
                null,
                Icons.edit_location),
          ),
          _createLocationButton(),
        ],
      ),
      Divider(),
      _createDropdown(_account.person.province.name, _provinces, _setProvince),
      Divider(),
      _createInputDate(context),
      Divider(),
      _createDropdown(_account.person.sex, _sexs, _setSex),
      Divider(),
      SizedBox(
        height: 20.0,
      ),
      _createSaveButton(context),
    ];
  }

  Widget _createInput(
      String hintText,
      String labelText,
      String errorMessage,
      TextEditingController controller,
      Function onChangeFunction,
      Function condition,
      IconData suffixIcon,
      IconData iconData) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          counter: Text('${controller.text.length}'),
          hintText: hintText,
          labelText: labelText,
          suffixIcon: Icon(suffixIcon),
          icon: Icon(iconData)),
      onChanged: onChangeFunction,
      validator: (value) {
        if (condition(value)) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  Widget _createLocationButton() {
    return FloatingActionButton(
      onPressed: () {
        _getLocationFromLiveMapPage();
      },
      child: Icon(Icons.add_location),
    );
  }

  _getLocationFromLiveMapPage() async {
    Position positionResult = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LiveMap(),
        ));
    if (positionResult != null) {
      _account.person.location = Location(
          latitude: positionResult.latitude,
          longitude: positionResult.longitude);
    }
  }

  List<DropdownMenuItem<String>> _getOptionsDropdown(List<dynamic> options) {
    List<DropdownMenuItem<String>> list = new List();
    options.forEach((option) {
      list.add(DropdownMenuItem(
        child: Text((option is String) ? option : option.name),
        value: (option is String) ? option : option.name,
      ));
    });

    return list;
  }

  Widget _createInputDate(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _birthDateController,
      decoration: InputDecoration(
          hintText: 'Fecha de nacimiento en dia/mes/año',
          labelText: 'Fecha de nacimiento',
          suffixIcon: Icon(Icons.perm_contact_calendar),
          icon: Icon(Icons.calendar_today)),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - adultAge),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(), //DateTime(DateTime.now().year - adultAge),
      locale: Locale('es', 'ES'),
    );

    if (picked != null) {
      setState(() {
        _account.person.birthDate = picked;
        _birthDateController.text = dateFormat.format(picked);
      });
    }
  }

  Widget _createDropdown(
      String value, List<dynamic> options, Function onChangeFunction) {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: value,
            items: _getOptionsDropdown(options),
            onChanged: onChangeFunction,
          ),
        )
      ],
    );
  }

  Widget _createSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          _showConfirmation(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save_alt),
            SizedBox(
              width: 5.0,
            ),
            Text('Guardar'),
          ],
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
              FlatButton(
                child: Text('Guardar'),
                onPressed: () {
                  Navigator.pop(context);
                  if (_formKey.currentState.validate()) {
                    _saveProfile(context);
                  }
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

  _saveProfile(BuildContext context) async {
    _showCircularProgressIndicator(true);
    bool result = await _getPerson();
    _showCircularProgressIndicator(false);
    if (result)
      _launchAlert('Se guardaron exitosamente los datos.');
    else
      _launchAlert('Ocurrió un error al guardar los datos.');
  }

  Future<bool> _getPerson() async {
    return await profileProvider.putPerson(_account.person);
  }

  _launchAlert(String result) {
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
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ],
          );
        });
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

  _setAddress(address) {
    setState(() => _account.person.address = address);
  }

  _setphone(phone) {
    setState(() => _account.person.phone = phone);
  }

  _setSex(sex) {
    setState(() => _account.person.sex = sex);
  }

  _setProvince(String province) {
    setState(() => _account.person.province = (_provinces == null)
        ? Province(name: 'Asunción')
        : _provinces
            .where((provinceItem) => provinceItem.name == province)
            .toList()[0]);
  }

  _showCircularProgressIndicator(bool value) {
    setState(() {
      _load = value;
    });
  }

  _nonEmptyValidation(String value) {
    if (value.isNotEmpty)
      return false;
    else
      return true;
  }

  _nonEmptyAddress(String value) {
    if (value.isNotEmpty && _account.person.location != null) {
      return false;
    } else
      return true;
  }
}
