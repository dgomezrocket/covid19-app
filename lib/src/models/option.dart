class Option {
  int? id;
  String title;
  String subtitle;
  String type;
  int orderLevel;

  Option({this.id, required this.title, required this.subtitle, required this.type, required this.orderLevel});

  factory Option.fromJson(dynamic json) {
    return Option(
        id: json['id'] as int?,
        title: json['title'] as String? ?? '',
        subtitle: json['subtitle'] as String? ?? '',
        type: json['type'] as String? ?? '',
        orderLevel: json['orderLevel'] as int? ?? 0);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'type': type,
        'orderLevel': orderLevel,
      };

  @override
  String toString() {
    return '{ $id, $title, $subtitle, $type, $orderLevel }';
  }
}
