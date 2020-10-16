import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:covid19/src/providers/provider.dart';
import 'package:covid19/src/screens/home_screen.dart';
import 'package:covid19/src/screens/login_screen.dart';
import 'package:covid19/src/services/auth_service.dart';
import 'package:covid19/src/utils/routes.dart';
import 'package:covid19/src/utils/widgets.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: "MSPBS",
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('es', 'ES'),
        ],
        home: FutureBuilder(
          future: AuthService.getToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return createCircularProgressIndicator();
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
