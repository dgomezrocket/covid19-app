import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/models/role.dart';

class Account {
  int id;
  String email;
  Person person;
  List<Role> roles;

  Account({this.id, this.email, this.person, this.roles});

  factory Account.fromJson(dynamic json) {
    if (json['roles'] != null) {
      var rolesObjsJson = json['roles'] as List;

      List<Role> _roles =
          rolesObjsJson.map((role) => Role.fromJson(role)).toList();

      return Account(
          id: json['id'] as int,
          email: json['email'] as String,
          person: Person.fromJson(json['person']),
          roles: _roles);
    } else
      return Account(
          id: json['id'] as int,
          email: json['email'] as String,
          person: Person.fromJson(json['person']));
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.email}, ${this.person}, ${this.roles} }';
  }
}
