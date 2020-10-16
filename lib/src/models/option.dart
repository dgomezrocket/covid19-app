class Option {
  int id;
  String title;
  String subtitle;
  String type;

  Option({this.id, this.title, this.subtitle, this.type});

  factory Option.fromJson(dynamic json) {
    return Option(
        id: json['id'] as int,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        type: json['type'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.title}, ${this.subtitle}, ${this.type} }';
  }
}
