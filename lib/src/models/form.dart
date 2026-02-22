import 'dart:convert';

import 'package:covid19/src/models/item.dart';

class FormPerson {
  int? id;
  String title;
  String subtitle;
  int orderLevel;
  List<Item> itemsForm;

  FormPerson({
    this.id,
    required this.title,
    required this.subtitle,
    required this.orderLevel,
    required this.itemsForm,
  });

  factory FormPerson.fromJson(dynamic json) {
    List<Item> itemsForm = [];
    if (json['itemsForm'] != null) {
      var itemsFormObjsJson = json['itemsForm'] as List;
      itemsForm = itemsFormObjsJson
          .map((itemFormJson) => Item.fromJson(itemFormJson))
          .toList();
    }

    return FormPerson(
        id: json['id'] as int?,
        title: json['title'] as String? ?? '',
        subtitle: json['subtitle'] as String? ?? '',
        orderLevel: json['orderLevel'] as int? ?? 0,
        itemsForm: itemsForm);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'orderLevel': orderLevel,
      };

  @override
  String toString() {
    return '{ $id, $title, $subtitle, $orderLevel, $itemsForm }';
  }
}
