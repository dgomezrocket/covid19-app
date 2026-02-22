import 'package:covid19/src/models/item.dart';

class ItemsAnswer {
  int? id;
  String? answerText;
  Item item;

  ItemsAnswer({this.id, this.answerText, required this.item});

  factory ItemsAnswer.fromJson(dynamic json) {
    return ItemsAnswer(
        id: json['id'] as int?,
        answerText: json['answerText'] as String?,
        item: Item.fromJson(json['item']));
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'answerText': answerText, 'item': item.toJson()};

  @override
  String toString() {
    return '{ $id, $answerText, $item }';
  }
}
