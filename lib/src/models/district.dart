import 'package:covid19/src/models/province.dart';

class District {
  int? id;
  String name;
  Province? province;

  District({this.id, required this.name, this.province});

  factory District.fromJson(dynamic json) {
    return District(
        id: json['id'] as int?,
        name: json['name'] as String? ?? '',
        province: json['province'] != null ? Province.fromJson(json['province']) : null);
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'province': province?.toJson()};

  @override
  String toString() {
    return '{ $id, $name, $province }';
  }
}
