import 'package:covid19/src/models/district.dart';
import 'package:covid19/src/models/location.dart';

class Hospital {
  int? id;
  String name;
  String address;
  String code;
  bool state;
  String phone;
  String area;
  String director;
  String type;
  District? district;
  Location location;

  Hospital({
    this.id,
    required this.name,
    required this.address,
    required this.code,
    required this.state,
    required this.phone,
    required this.area,
    required this.director,
    required this.type,
    this.district,
    required this.location,
  });

  factory Hospital.fromJson(dynamic json) {
    return Hospital(
        id: json['id'] as int?,
        name: json['name'] as String? ?? '',
        address: json['address'] as String? ?? '',
        code: json['code'] as String? ?? '',
        state: json['state'] as bool? ?? false,
        phone: json['phone'] as String? ?? '',
        area: json['area'] as String? ?? '',
        director: json['director'] as String? ?? '',
        type: json['type'] as String? ?? '',
        district: json['district'] != null ? District.fromJson(json['district']) : null,
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
        'district': district?.toJson(),
        'location': location.toJson()
      };

  @override
  String toString() {
    return '{ $id, $name, $address, $code, $state, $phone, $area, $director, $type, $district, $location }';
  }
}
