import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:covid19/src/services/auth_service.dart';
import 'package:rxdart/rxdart.dart';

import 'package:covid19/src/mixins/validation_mixin.dart';

class FormBloc with ValidationMixin {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _errorMessage = BehaviorSubject<String?>();

  Function(String) get changeEmail {
    addError(null);
    return _email.sink.add;
  }

  Function(String) get changePassword {
    addError(null);
    return _password.sink.add;
  }

  Function(String?) get addError => _errorMessage.sink.add;

  Stream<String> get email => _email.stream.transform(validatorEmail);
  Stream<String> get password => _password.stream.transform(validatorPassword);
  Stream<String?> get errorMessage => _errorMessage.stream;

  Stream<bool> get submitValidForm => Rx.combineLatest3(
        email,
        password,
        errorMessage,
        (e, p, er) => true,
      );

  Future<Map<String, dynamic>> register(BuildContext context) async {
    final authInfo = AuthService();

    final res = await authInfo.register(_email.value, _password.value);
    final data = jsonDecode(res) as Map<String, dynamic>;
    return data;
  }

  void treatRegisterRestult(
      Map<String, dynamic> result, BuildContext context) async {
    if (result['status'] != null) {
      await Future.delayed(Duration(milliseconds: 100));
      addError(result['message']);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
  }

  Future<Map<String, dynamic>> login(BuildContext context) async {
    final authInfo = AuthService();

    final res = await authInfo.login(_email.value, _password.value);
    final data = jsonDecode(res) as Map<String, dynamic>;

    return data;
  }

  void treatLoginResult(Map<String, dynamic> result, BuildContext context) async {
    if (result['status'] != null) {
      await Future.delayed(Duration(milliseconds: 100));
      addError(result['message']);
    } else {
      AuthService.setToken(result['jwt']);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }
  }

  void dispose() {
    _email.close();
    _password.close();
    _errorMessage.close();
  }
}
