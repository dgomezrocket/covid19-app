import 'package:covid19/src/models/district.dart';
import 'package:covid19/src/models/location.dart';

class Hospital {
  int id;
  String name;
  String address;
  String code;
  bool state;
  String phone;
  String area;
  String director;
  String type;
  District district;
  Location location;

  Hospital(
      {this.id,
      this.name,
      this.address,
      this.code,
      this.state,
      this.phone,
      this.area,
      this.director,
      this.type,
      this.district,
      this.location});

  factory Hospital.fromJson(dynamic json) {
    return Hospital(
        id: json['id'] as int,
        name: json['name'] as String,
        address: json['address'] as String,
        code: json['code'] as String,
        state: json['state'] as bool,
        phone: json['phone'] as String,
        area: json['area'] as String,
        director: json['director'] as String,
        type: json['type'] as String,
        district: District.fromJson(json['district']),
        location: Location.fromJson(json['location']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'code': code,
        'state': state,
        'phone': phone,
        'area': area,
        'director': director,
        'type': type,
        'district': district.toJson(),
        'location': location.toJson()
      };

  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.address}, ${this.code}, ${this.state}, ${this.phone}, ${this.area}, ${this.director}, ${this.type}, ${this.district}, ${this.location} }';
  }
}
