import 'package:flutter/material.dart';

import 'package:covid19/src/mixins/helper.dart';

import 'package:covid19/src/blocs/form_bloc.dart';
import 'package:covid19/src/providers/provider.dart';
import 'package:covid19/src/utils/widgets.dart';

class LoginScreen extends StatefulWidget {
  // single approch way
  // final bloc = new FormBloc();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _load = false;

  Widget loadingIndicator;

  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = Provider.of(context);
    loadingIndicator = !_load ? new Container() : createLoader();

    return Scaffold(
        body: Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 100.0, left: 50.0, right: 50.0),
                height: 550.0,
                child: Form(
                  child: Column(
                    children: <Widget>[
                      _emailField(formBloc),
                      _passwordField(formBloc),
                      Container(
                        width: 300,
                        height: 35,
                        child: Helper().errorMessage(formBloc),
                      ),
                      //_checkBox(),
                      _buttonField(formBloc),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, '/forgot_password'),
                            child: Container(
                              child: Text('Olvidaste la contraseña?'),
                              alignment: Alignment.bottomLeft,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/signup'),
                            child: Container(
                              child: Text('Registrarse'),
                              alignment: Alignment.bottomLeft,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          child: loadingIndicator,
          alignment: FractionalOffset.center,
        ),
      ],
    ));
  }

  Widget _emailField(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'correo@ejemplo.com',
              labelText: 'Correo',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          );
        });
  }

  Widget _passwordField(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
            obscureText: true,
            onChanged: bloc.changePassword,
            maxLength: 20,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Contraseña',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _checkBox() {
    return Row(
      children: <Widget>[
        Checkbox(
          onChanged: (checked) => {},
          value: true,
        ),
        Text('Mantenerme conectado'),
      ],
    );
  }

  Widget _buttonField(FormBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.submitValidForm,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: () {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return null;
                }
                _showCircularProgressIndicator(true);
                bloc.login(context);
                _showCircularProgressIndicator(false);
              },
              child: const Icon(Icons.arrow_forward),
              color: Colors.amber,
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              disabledColor: Colors.blueGrey,
              disabledElevation: 10,
              disabledTextColor: Colors.white,
            ),
          );
        });
  }

  _showCircularProgressIndicator(bool value) {
    setState(() {
      _load = value;
    });
  }
}
