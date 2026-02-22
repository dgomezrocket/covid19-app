import 'package:covid19/src/models/message_item.dart';
import 'package:covid19/src/utils/styles_options.dart';
import 'package:covid19/src/utils/util_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBox extends StatefulWidget {
  final List<MessageItem> messages;

  MessageBox({required this.messages});

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final _dateFormat = DateFormat(dateFormatWithHourString);
  late List<Widget> messageBoxes;

  @override
  Widget build(BuildContext context) {
    messageBoxes = widget.messages.map(_buildMessage).toList();
    return Container(
      child: ListView(
        reverse: true,
        padding: EdgeInsets.only(top: 15.0),
        children: messageBoxes.reversed.toList(),
      ),
    );
  }

  Widget _buildMessage(MessageItem message) {
    final isMe = message.receiver;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: MediaQuery.of(context).size.width * 0.15, //80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: MediaQuery.of(context).size.width * 0.15,
            ),
      decoration: BoxDecoration(
        color: isMe ? Colors.blue[200] : Colors.blue[50],
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                message.messageDate != null 
                    ? _dateFormat.format(message.messageDate!)
                    : '',
                style: title_bold_style,
              ),
              Expanded(
                  child: SizedBox(
                width: 1.0,
              )),
              Text(
                message.person.name,
                style: title_bold_style,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            message.messageText,
            style: title_style,
          ),
        ],
      ),
    );
  }
}
