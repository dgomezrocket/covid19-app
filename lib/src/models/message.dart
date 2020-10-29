class Message {
  int id;
  String messageText;
  DateTime sendDate;
  int personSenderId;
  int personReceivedId;

  Message(
      {this.id,
      this.messageText,
      this.sendDate,
      this.personSenderId,
      this.personReceivedId});

  factory Message.fromJson(dynamic json) {
    return Message(
        id: json['id'] as int,
        messageText: json['messageText'] as String,
        sendDate: json['sendDate'] == null
            ? null
            : DateTime.parse(json['sendDate'].toString()),
        personSenderId: json['personSenderId'] as int,
        personReceivedId: json['personReceivedId'] as int);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'messageText': messageText,
        'sendDate': sendDate == null ? null : sendDate.toIso8601String(),
        'personSenderId': personSenderId,
        'personReceivedId': personReceivedId
      };

  @override
  String toString() {
    return '{ ${this.id}, ${this.messageText}, ${this.sendDate}, ${this.personSenderId}, ${this.personReceivedId} }';
  }
}
