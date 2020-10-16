class Status {
  int id;
  String name;

  Status({this.id, this.name});

  factory Status.fromJson(dynamic json) {
    return Status(id: json['id'] as int, name: json['name'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.name} }';
  }
}
