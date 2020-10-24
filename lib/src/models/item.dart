import 'dart:convert';

import 'package:covid19/src/models/option.dart';

class Item {
  int id;
  String title;
  String subtitle;
  String type;
  int orderLevel;
  List<Option> optionsItem;

  Item(
      {this.id,
      this.title,
      this.subtitle,
      this.type,
      this.orderLevel,
      this.optionsItem});

  factory Item.fromJson(dynamic json) {
    if (json['optionsItem'] != null) {
      var optionsItemObjsJson = json['optionsItem'] as List;

      List<Option> _optionsItem = optionsItemObjsJson
          .map((optionItemJson) => Option.fromJson(optionItemJson))
          .toList();

      return Item(
          id: json['id'] as int,
          title: json['title'] as String,
          subtitle: json['subtitle'] as String,
          type: json['type'] as String,
          orderLevel: json['orderLevel'] as int,
          optionsItem: _optionsItem);
    } else
      return Item(
          id: json['id'] as int,
          title: json['title'] as String,
          subtitle: json['subtitle'] as String,
          type: json['type'] as String,
          orderLevel: json['orderLevel'] as int);
  }

  Map<String, dynamic> toJson() {
    if (this.optionsItem != null)
      return {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'type': type,
        'orderLevel': orderLevel,
        'optionsItem':
            optionsItem.map((optionItem) => optionItem.toJson()).toList()
      };
    else
      return {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'type': type,
        'orderLevel': orderLevel,
      };
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.title}, ${this.subtitle}, ${this.type}, ${this.orderLevel}, ${this.optionsItem} }';
  }
}
