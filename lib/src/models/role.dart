class Role {
  int id;
  String name;

  Role({this.id, this.name});

  factory Role.fromJson(dynamic json) {
    return Role(id: json['id'] as int, name: json['name'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.name} }';
  }
}
