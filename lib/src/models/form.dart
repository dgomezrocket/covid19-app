import 'package:covid19/src/models/item.dart';

class Person {
  int id;
  String title;
  String subtitle;
  String type;
  List<Item> itemsForm;

  Person({this.id, this.title, this.subtitle, this.type, this.itemsForm});
}
