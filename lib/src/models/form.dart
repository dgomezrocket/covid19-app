import 'package:covid19/src/models/item.dart';

class FormPerson {
  int id;
  String title;
  String subtitle;
  List<Item> itemsForm;

  FormPerson({this.id, this.title, this.subtitle, this.itemsForm});

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
          itemsForm: _itemsForm);
    } else
      return FormPerson(
          id: json['id'] as int,
          title: json['title'] as String,
          subtitle: json['subtitle'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.title}, ${this.subtitle}, ${this.itemsForm} }';
  }
}
