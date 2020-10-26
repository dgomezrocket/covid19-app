import 'package:covid19/src/pages/answers_page.dart';
import 'package:flutter/material.dart';

import 'package:covid19/src/pages/profile_page.dart';
import 'package:covid19/src/pages/forms_page.dart';
import 'package:covid19/src/services/auth_service.dart';
import 'package:covid19/src/pages/map_page.dart';
// import 'package:covid19/src/pages/livemap_location.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    ProfilePage(),
    FormsPage(),
    AnswersPage(),
    OSMMap(), //LiveMap()
    //OtherMap()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: [
          Text('Conacyt App'),
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
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
      ),
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
