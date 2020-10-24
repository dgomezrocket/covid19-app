import 'dart:convert';

import 'package:covid19/src/models/item.dart';

class FormPerson {
  int id;
  String title;
  String subtitle;
  int orderLevel;
  List<Item> itemsForm;

  FormPerson(
      {this.id, this.title, this.subtitle, this.orderLevel, this.itemsForm});

  factory FormPerson.fromJson(dynamic json) {
    if (json['itemsForm'] != null) {
      var itemsFormObjsJson = json['itemsForm'] as List;

      List<Item> _itemsForm = itemsFormObjsJson
          .map((itemFormJson) => Item.fromJson(itemFormJson))
          .toList();

      return FormPerson(
          id: json['id'] as int,
          title: json['title'] as String,
          subtitle: json['subtitle'] as String,
          orderLevel: json['orderLevel'] as int,
          itemsForm: _itemsForm);
    } else
      return FormPerson(
          id: json['id'] as int,
          title: json['title'] as String,
          subtitle: json['subtitle'] as String,
          orderLevel: json['orderLevel'] as int);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'orderLevel': orderLevel,
      };

  @override
  String toString() {
    return '{ ${this.id}, ${this.title}, ${this.subtitle}, ${this.orderLevel}, ${this.itemsForm} }';
  }
}
