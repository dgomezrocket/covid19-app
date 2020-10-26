import 'package:covid19/src/models/location.dart';

class Hospital {
  int id;
  String name;
  String address;
  Location location;

  Hospital({this.id, this.name, this.address, this.location});

  factory Hospital.fromJson(dynamic json) {
    return Hospital(
        id: json['id'] as int,
        name: json['name'] as String,
        address: json['address'] as String,
        location: Location.fromJson(json['location']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'location': location.toJson()
      };

  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.address}, ${this.location} }';
  }
}
