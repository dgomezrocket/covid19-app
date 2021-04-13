import 'package:covid19/src/models/province.dart';

class District {
  int id;
  String name;
  Province province;

  District({this.id, this.name, this.province});

  factory District.fromJson(dynamic json) {
    if (json != null)
      return District(
          id: json['id'] as int,
          name: json['name'] as String,
          province: Province.fromJson(json['province']));
    else
      return null;
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'province': province.toJson()};

  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.province} }';
  }
}
