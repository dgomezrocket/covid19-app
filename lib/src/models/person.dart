import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/models/status.dart';

class Person {
  int id;
  String document;
  String name;
  String lastname;
  DateTime birthDate;
  String phone;
  String sex;
  String address;
  Location location;
  Status status;

  Person(
      {this.id,
      this.document,
      this.name,
      this.lastname,
      this.birthDate,
      this.phone,
      this.sex,
      this.address,
      this.location,
      this.status});

  factory Person.fromJson(dynamic json) {
    return Person(
        id: json['id'] as int,
        document: json['document'] as String,
        name: json['name'] as String,
        lastname: json['lastname'] as String,
        birthDate: json['birthDate'] == null
            ? null
            : DateTime.parse(json['birthDate'].toString()),
        phone: json['phone'] as String,
        sex: json['sex'] as String,
        address: json['address'] as String,
        location: Location.fromJson(json['location']),
        status: Status.fromJson(json['status']));
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.document}, ${this.name}, ${this.lastname}, ${this.birthDate}, ${this.phone}, ${this.sex}, ${this.address}, ${this.location}, ${this.status} }';
  }
}
