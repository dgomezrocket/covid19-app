class Province {
  int? id;
  String code;
  String name;
  String capital;

  Province({this.id, required this.code, required this.name, required this.capital});

  factory Province.fromJson(dynamic json) {
    return Province(
        id: json['id'] as int?,
        code: json['code'] as String? ?? '',
        name: json['name'] as String? ?? '',
        capital: json['capital'] as String? ?? '');
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'code': code, 'name': name, 'capital': capital};

  @override
  String toString() {
    return '{ $id, $code, $name, $capital }';
  }
}
