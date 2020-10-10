import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/models/status.dart';

class Person {
  int id;
  String document;
  String name;
  String lastname;
  String phone;
  String sex;
  Location location;
  Status status;

  Person(
      {this.id,
      this.document,
      this.name,
      this.lastname,
      this.phone,
      this.sex,
      this.location,
      this.status});
}
