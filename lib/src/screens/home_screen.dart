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
  Future<Person> _personFetched;
  bool _isLogged = false;

  @override
  void initState() {
    _personFetched = _loadData();
    return super.initState();
  }

  Future<Person> _loadData() async {
    _isLogged = await isLoggedUser();
    if (_isLogged)
      return profileProvider.getPerson();
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _personFetched,
      initialData: null,
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

  _loadHome(AsyncSnapshot<dynamic> snapshot) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: [
          Text('CroniApp'),
          Expanded(
              child: SizedBox(
            width: 5.0,
          )),
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

  _createBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Datos'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.assessment),
          title: Text('Formularios'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.assessment),
          title: Text('Respuestas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_location),
          title: Text('Hospitales'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.mail),
          title: Text('Mensajes'),
        ),
      ],
    );
  }

  _logout(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Salir'),
        content: Text('¿Está seguro que desea salir?'),
        actions: [
          FlatButton(
              child: Text('Sí'),
              onPressed: () {
                AuthService.removeToken();
                Navigator.popAndPushNamed(context, '/login');
              }),
          FlatButton(
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
