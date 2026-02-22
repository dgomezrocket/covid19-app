import 'package:covid19/src/models/message_item.dart';
import 'package:covid19/src/models/person.dart';

class MessageResponse {
  List<MessageItem> messages;
  Person myData;

  MessageResponse({required this.messages, required this.myData});

  factory MessageResponse.fromJson(dynamic json) {
    List<MessageItem> messages = [];
    if (json['messages'] != null) {
      var messageItemsObjsJson = json['messages'] as List;
      messages = messageItemsObjsJson
          .map((messageItem) => MessageItem.fromJson(messageItem))
          .toList();
    }

    return MessageResponse(
        messages: messages, myData: Person.fromJson(json['myData']));
  }

  Map<String, dynamic> toJson() => {
        'messages': messages.map((messageItem) => messageItem.toJson()).toList(),
        'myData': myData.toJson()
      };

  @override
  String toString() {
    return '{ $messages }';
  }
}
