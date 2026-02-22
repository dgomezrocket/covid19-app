class Message {
  int? id;
  String messageText;
  DateTime? sendDate;
  int personSenderId;
  int personReceivedId;

  Message({
    this.id,
    required this.messageText,
    this.sendDate,
    required this.personSenderId,
    required this.personReceivedId,
  });

  factory Message.fromJson(dynamic json) {
    return Message(
        id: json['id'] as int?,
        messageText: json['messageText'] as String? ?? '',
        sendDate: json['sendDate'] == null
            ? null
            : DateTime.parse(json['sendDate'].toString()),
        personSenderId: json['personSenderId'] as int? ?? 0,
        personReceivedId: json['personReceivedId'] as int? ?? 0);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'messageText': messageText,
        'sendDate': sendDate?.toIso8601String(),
        'personSenderId': personSenderId,
        'personReceivedId': personReceivedId
      };

  @override
  String toString() {
    return '{ $id, $messageText, $sendDate, $personSenderId, $personReceivedId }';
  }
}
