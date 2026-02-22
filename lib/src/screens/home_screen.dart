import 'package:covid19/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:covid19/src/pages/profile_page.dart';
import 'package:covid19/src/pages/forms_page.dart';
import 'package:covid19/src/pages/answers_page.dart';
import 'package:covid19/src/pages/message_page.dart';
import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/utils/functions_utils.dart';
import 'package:covid19/src/utils/widgets.dart';
import 'package:covid19/src/services/auth_service.dart';
import 'package:covid19/src/pages/map_page.dart';

class Home extends StatefulWidget {
  final List<Widget> screens = [
    ProfilePage(),
    FormsPage(),
    AnswersPage(),
    OSMMap(),
    MessagePage()
  ];

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  Future<Person?>? _personFetched;
  bool _isLogged = false;

  @override
  void initState() {
    super.initState();
    _personFetched = _loadData();
  }

  Future<Person?> _loadData() async {
    _isLogged = await isLoggedUser();
    if (_isLogged) {
      return profileProvider.getPerson();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Person?>(
      future: _personFetched,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return createCircularProgressIndicator();
        } else if (_isLogged) {
          return _loadHome(snapshot);
        } else {
          return LoginScreen();
        }
      },
    );
  }

  Widget _loadHome(AsyncSnapshot<Person?> snapshot) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: [
          Text('CroniApp'),
          Expanded(child: SizedBox(width: 5.0)),
          GestureDetector(
              child: Text("Salir",
                  style: TextStyle(
                    fontSize: 10.0,
                    decoration: TextDecoration.underline,
                  )),
              onTap: () {
                _logout(context);
              }),
        ]),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: widget.screens[_currentIndex],
      ),
      bottomNavigationBar:
          snapshot.hasData ? _createBottomNavigationBar() : null,
    );
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Datos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Formularios',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Respuestas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_location),
          label: 'Hospitales',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Mensajes',
        ),
      ],
    );
  }

  Future<bool?> _logout(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Salir'),
        content: Text('¿Está seguro que desea salir?'),
        actions: [
          TextButton(
              child: Text('Sí'),
              onPressed: () {
                AuthService.removeToken();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              }),
          TextButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
