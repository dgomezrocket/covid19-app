import 'package:flutter/material.dart';
import 'package:covid19/src/blocs/form_bloc.dart';

class Helper {
  Widget errorMessage(FormBloc bloc) {
    return StreamBuilder<String?>(
      stream: bloc.errorMessage,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Text(snapshot.data!, style: TextStyle(color: Colors.red));
        }
        return Text('');
      },
    );
  }
}
