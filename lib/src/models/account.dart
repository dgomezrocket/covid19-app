import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/models/role.dart';

class Account {
  int? id;
  String email;
  Person? person;
  List<Role>? roles;

  Account({this.id, required this.email, this.person, this.roles});

  factory Account.fromJson(dynamic json) {
    List<Role>? roles;
    if (json['roles'] != null) {
      var rolesObjsJson = json['roles'] as List;
      roles = rolesObjsJson.map((role) => Role.fromJson(role)).toList();
    }

    return Account(
        id: json['id'] as int?,
        email: json['email'] as String? ?? '',
        person: json['person'] != null ? Person.fromJson(json['person']) : null,
        roles: roles);
  }

  @override
  String toString() {
    return '{ $id, $email, $person, $roles }';
  }
}
