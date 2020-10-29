import 'package:covid19/src/models/message_item.dart';

import 'package:covid19/src/models/person.dart';

class MessageResponse {
  List<MessageItem> messages;
  Person myData;

  MessageResponse({this.messages, this.myData});

  factory MessageResponse.fromJson(dynamic json) {
    if (json['messages'] != null) {
      var messageItemsObjsJson = json['messages'] as List;

      List<MessageItem> _messageItems = messageItemsObjsJson
          .map((messageItem) => MessageItem.fromJson(messageItem))
          .toList();

      return MessageResponse(
          messages: _messageItems, myData: Person.fromJson(json['myData']));
    } else
      return MessageResponse(myData: Person.fromJson(json['myData']));
  }

  Map<String, dynamic> toJson() {
    if (this.messages != null)
      return {
        'messages':
            messages.map((messageItem) => messageItem.toJson()).toList(),
        'myData': myData.toJson()
      };
    else
      return {'myData': myData.toJson()};
  }

  @override
  String toString() {
    return '{ ${this.messages} }';
  }
}
