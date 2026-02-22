import 'package:flutter/material.dart';

import 'package:covid19/src/blocs/form_bloc.dart';

class Provider extends InheritedWidget {
  final bloc = FormBloc();

  Provider({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget _) {
    return true;
  }

  static FormBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())!.bloc;
  }
}
