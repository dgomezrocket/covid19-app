import 'package:flutter/material.dart';

import 'package:covid19/src/mixins/helper.dart';
import 'package:covid19/src/blocs/form_bloc.dart';
import 'package:covid19/src/providers/provider.dart';
import 'package:covid19/src/utils/widgets.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _load = false;
  Widget? loadingIndicator;

  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = Provider.of(context);
    loadingIndicator = !_load ? Container() : createLoader();

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
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
                      _buttonField(formBloc),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: loadingIndicator,
          ),
        ],
      ),
    );
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
              errorText: snapshot.error?.toString(),
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
              errorText: snapshot.error?.toString(),
            ),
          );
        });
  }

  Widget _buttonField(FormBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.submitValidForm,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                if (snapshot.hasError) {
                  return;
                }
                _register(bloc, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                elevation: 10,
              ),
              child: const Icon(Icons.arrow_forward),
            ),
          );
        });
  }

  Future<void> _register(FormBloc bloc, BuildContext context) async {
    _showCircularProgressIndicator(true);
    Map<String, dynamic> result = await bloc.register(context);
    _showCircularProgressIndicator(false);
    bloc.treatRegisterRestult(result, context);
  }

  void _showCircularProgressIndicator(bool value) {
    setState(() {
      _load = value;
    });
  }
}
