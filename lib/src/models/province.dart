class Province {
  int id;
  String code;
  String name;
  String capital;

  Province({this.id, this.code, this.name, this.capital});

  factory Province.fromJson(dynamic json) {
    if (json != null)
      return Province(
          id: json['id'] as int,
          code: json['code'] as String,
          name: json['name'] as String,
          capital: json['capital'] as String);
    else
      return null;
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'code': code, 'name': name, 'capital': capital};

  @override
  String toString() {
    return '{ ${this.id}, ${this.code}, ${this.name}, ${this.capital} }';
  }
}
