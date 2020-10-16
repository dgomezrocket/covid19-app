import 'package:covid19/src/models/person.dart';
import 'package:covid19/src/models/role.dart';

class Account {
  int id;
  String email;
  Person person;
  Role role;

  Account({this.id, this.email, this.person, this.role});

  factory Account.fromJson(dynamic json) {
    return Account(
        id: json['id'] as int,
        email: json['email'] as String,
        person: Person.fromJson(json['person']),
        role: Role.fromJson(json['role']));
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.email}, ${this.person}, ${this.role} }';
  }
}
