import 'package:covid19/src/models/option.dart';

class Item {
  int? id;
  String title;
  String subtitle;
  String type;
  int orderLevel;
  List<Option>? optionsItem;

  Item({
    this.id,
    required this.title,
    required this.subtitle,
    this.type = '',
    this.orderLevel = 0,
    this.optionsItem,
  });

  factory Item.fromJson(dynamic json) {
    List<Option>? optionsItem;
    if (json['optionsItem'] != null) {
      var optionsItemObjsJson = json['optionsItem'] as List;
      optionsItem = optionsItemObjsJson
          .map((optionItemJson) => Option.fromJson(optionItemJson))
          .toList();
    }

    return Item(
        id: json['id'] as int?,
        title: json['title'] as String? ?? '',
        subtitle: json['subtitle'] as String? ?? '',
        type: json['type'] as String? ?? '',
        orderLevel: json['orderLevel'] as int? ?? 0,
        optionsItem: optionsItem);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'type': type,
      'orderLevel': orderLevel,
    };
    if (optionsItem != null) {
      map['optionsItem'] = optionsItem!.map((optionItem) => optionItem.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return '{ $id, $title, $subtitle, $type, $orderLevel, $optionsItem }';
  }
}
