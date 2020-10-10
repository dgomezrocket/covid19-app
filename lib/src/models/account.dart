import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/models/role.dart';

class Account {
  int id;
  String email;
  Person person;
  Role role;

  Account({this.id, this.email, this.person, this.role});
}
