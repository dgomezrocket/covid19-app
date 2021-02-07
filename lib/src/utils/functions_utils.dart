import 'package:covid19/src/services/auth_service.dart';

T cast<T>(x) => x is T ? x : null;

Future<bool> isLoggedUser() async {
  dynamic tokenMap = await AuthService.getTokenJwt();
  return (tokenMap != null);
}
