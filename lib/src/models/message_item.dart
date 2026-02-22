import 'package:covid19/src/models/person.dart';

class MessageItem {
  int? id;
  String messageText;
  DateTime? messageDate;
  Person person;
  bool receiver;

  MessageItem({
    this.id,
    required this.messageText,
    this.messageDate,
    required this.person,
    required this.receiver,
  });

  factory MessageItem.fromJson(dynamic json) {
    return MessageItem(
      id: json['id'] as int?,
      messageText: json['messageText'] as String? ?? '',
      messageDate: json['messageDate'] == null
          ? null
          : DateTime.parse(json['messageDate'].toString()),
      person: Person.fromJson(json['person']),
      receiver: json['receiver'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'messageText': messageText,
    'messageDate': messageDate?.toIso8601String(),
    'person': person.toJson(),
    'receiver': receiver,
  };

  @override
  String toString() {
    return '{ $id, $messageText, $messageDate, $person, $receiver }';
  }
}