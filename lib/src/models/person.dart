import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/models/province.dart';
import 'package:covid19/src/models/status.dart';

class Person {
  int? id;
  String document;
  String name;
  String lastname;
  DateTime? birthDate;
  String phone;
  String sex;
  String address;
  Location? location;
  Status? status;
  Province? province;

  Person({
    this.id,
    required this.document,
    required this.name,
    required this.lastname,
    this.birthDate,
    required this.phone,
    required this.sex,
    required this.address,
    this.location,
    this.status,
    this.province,
  });

  factory Person.fromJson(dynamic json) {
    return Person(
        id: json['id'] as int?,
        document: json['document'] as String? ?? '',
        name: json['name'] as String? ?? '',
        lastname: json['lastname'] as String? ?? '',
        birthDate: json['birthDate'] == null
            ? null
            : DateTime.parse(json['birthDate'].toString()),
        phone: json['phone'] as String? ?? '',
        sex: json['sex'] as String? ?? '',
        address: json['address'] as String? ?? '',
        location: json['location'] != null ? Location.fromJson(json['location']) : null,
        status: json['status'] != null ? Status.fromJson(json['status']) : null,
        province: json['province'] != null ? Province.fromJson(json['province']) : null);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'document': document,
        'name': name,
        'lastname': lastname,
        'birthDate': birthDate?.toIso8601String(),
        'phone': phone,
        'sex': sex,
        'address': address,
        'location': location?.toJson(),
        'status': status?.toJson(),
        'province': province?.toJson()
      };

  @override
  String toString() {
    return '{ $id, $document, $name, $lastname, $birthDate, $phone, $sex, $address, $location, $status, $province }';
  }
}
