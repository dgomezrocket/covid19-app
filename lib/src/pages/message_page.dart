import 'package:flutter/material.dart';

import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/models/message_response.dart';
import 'package:covid19/src/models/message.dart';
import 'package:covid19/src/models/message_item.dart';
import 'package:covid19/src/options/message_option.dart';
import 'package:covid19/src/utils/widgets.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Future<MessageResponse?>? _messagesFetched;
  MessageResponse? _messageResponse;

  String _messageWrote = '';
  MessageBox? _messageBox;

  bool _load = false;
  Widget? loadingIndicator;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messagesFetched = _buildMessagePage();
  }

  @override
  Widget build(BuildContext context) {
    loadingIndicator = !_load ? Container() : createLoader();
    return FutureBuilder<MessageResponse?>(
      future: _messagesFetched,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return createCircularProgressIndicator();
        } else if (snapshot.hasData) {
          _messageResponse = snapshot.data;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: _messageBox ?? Container(),
                    ),
                    _buildMessageComposer(context),
                  ],
                ),
                Align(
                  alignment: FractionalOffset.center,
                  child: loadingIndicator,
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<MessageResponse?> _buildMessagePage() async {
    _messageResponse = await profileProvider.getMessages();
    if (_messageResponse != null) {
      _messageBox = MessageBox(
        messages: _messageResponse!.messages,
      );
    }
    return _messageResponse;
  }

  Widget _buildMessageComposer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.read_more),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                setState(() {
                  _messageWrote = value;
                });
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Escriba un mensaje...',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 4,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: (_messageWrote.isEmpty) ? null : _saveMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _saveMessage() async {
    _showCircularProgressIndicator(true);
    int receiverId = _getSenderId();
    Message messageToSend = Message(
      messageText: _messageWrote,
      personReceivedId: receiverId,
      personSenderId: _messageResponse?.myData.id ?? 0,
      sendDate: DateTime.now(),
    );
    await profileProvider.postMessage(messageToSend);
    setState(() {
      _messagesFetched = _buildMessagePage();
      _messageWrote = '';
      _controller.clear();
    });
    _showCircularProgressIndicator(false);
  }

  void _showCircularProgressIndicator(bool value) {
    setState(() {
      _load = value;
    });
  }

  int _getSenderId() {
    int idSender = 0;
    DateTime? date;
    if (_messageResponse?.messages != null) {
      for (MessageItem messageItem in _messageResponse!.messages) {
        if (_messageResponse?.myData.id != messageItem.person.id &&
            (date == null || (messageItem.messageDate != null && date.isBefore(messageItem.messageDate!)))) {
          idSender = messageItem.id ?? 0;
          date = messageItem.messageDate;
        }
      }
    }
    return idSender;
  }
}
