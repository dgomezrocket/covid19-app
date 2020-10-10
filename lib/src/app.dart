import 'package:covid19/src/utils/routes.dart';
import 'package:flutter/material.dart';

import 'package:covid19/src/providers/provider.dart';
import 'package:covid19/src/screens/home_screen.dart';
import 'package:covid19/src/screens/login_screen.dart';
import 'package:covid19/src/services/auth_service.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MSPBS",
        home: FutureBuilder(
          future: AuthService.getToken(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Home();
            } else {
              return LoginScreen();
            }
          },
        ),
        routes: getApplicationRoutes(),
      ),
    );
  }
}
