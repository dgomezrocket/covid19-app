class Status {
  int id;
  String name;

  Status({this.id, this.name});

  factory Status.fromJson(dynamic json) {
    return Status(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  String toString() {
    return '{ ${this.id}, ${this.name} }';
  }
}
