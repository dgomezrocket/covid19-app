import 'package:covid19/src/models/option.dart';

class Item {
  int id;
  String title;
  String subtitle;
  String type;
  List<Option> optionsItem;

  Item({this.id, this.title, this.subtitle, this.type, this.optionsItem});
}
