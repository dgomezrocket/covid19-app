import 'dart:async';

class ValidationMixin {
  final validatorEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (ValidationMixin()._validateEmail(email)) {
        sink.addError('El correo no es válido!');
      } else {
        sink.add(email);
      }
    },
  );

  final validatorPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (!ValidationMixin()._validatePassword(password)) {
        sink.addError('La contraseña no es válida!');
      } else {
        sink.add(password);
      }
    },
  );

  bool _validateEmail(String email) {
    var regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  bool _validatePassword(String password) {
    var regExp = RegExp(r'^(?=.*?[A-Z][a-z]).{8,}$');
    if (regExp.hasMatch(password)) {
      return false;
    }
    return true;
  }
}
