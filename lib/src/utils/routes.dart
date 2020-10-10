import 'package:flutter/material.dart';

import 'package:covid19/src/screens/forgot_password.dart';
import 'package:covid19/src/screens/home_screen.dart';
import 'package:covid19/src/screens/login_screen.dart';
import 'package:covid19/src/screens/signup_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/home': (BuildContext context) => Home(),
    '/login': (BuildContext context) => LoginScreen(),
    '/signup': (BuildContext context) => SignupScreen(),
    '/forgot_password': (BuildContext context) => ForgotPassword(),
  };
}
