import 'package:flutter/material.dart';

import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/models/message_response.dart';
import 'package:covid19/src/models/message.dart';
import 'package:covid19/src/options/message_option.dart';
import 'package:covid19/src/utils/functions_utils.dart';
import 'package:covid19/src/utils/widgets.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Future<MessageResponse> _messagesFetched;
  MessageResponse _messageResponse;

  String _messageWrote = '';
  MessageBox _messageBox;

  bool _load = false;
  Widget loadingIndicator;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _messagesFetched = _buildMessagePage();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadingIndicator = !_load ? new Container() : createLoader();
    return FutureBuilder(
      future: _messagesFetched,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return createCircularProgressIndicator();
        } else if (snapshot.hasData) {
          _loadData(snapshot.data);

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: _messageBox,
                    ),
                    _buildMessageComposer(context),
                  ],
                ),
                Align(
                  child: loadingIndicator,
                  alignment: FractionalOffset.center,
                ),
              ],
            ),
          );
        } else
          return Container();
      },
    );
  }

  _loadData(dynamic data) {
    if (data != null) _messageResponse = cast<MessageResponse>(data);
  }

  Future<MessageResponse> _buildMessagePage() async {
    _messageResponse = await profileProvider.getMessages();
    _messageBox = MessageBox(
      messages: _messageResponse.messages,
    );
    return _messageResponse;
  }

  _buildMessageComposer(BuildContext context) {
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
            //onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                _messageWrote = value;
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
            onPressed: () {
              //guardar mensaje en back
              _saveMessage();
            },
          ),
        ],
      ),
    );
  }

  _saveMessage() {
    _showCircularProgressIndicator(true);
    int receiverId = _getSenderId();
    Message messageToSend = Message(
      messageText: _messageWrote,
      personReceivedId: receiverId,
      personSenderId: _messageResponse.myData.id,
      sendDate: DateTime.now(),
    );
    profileProvider.postMessage(messageToSend);
    setState(() {
      _messageBox.state.addMessage(messageToSend, _messageResponse.myData);
      _messageWrote = '';
      _controller.clear();
    });
    _showCircularProgressIndicator(false);
  }

  _showCircularProgressIndicator(bool value) {
    setState(() {
      _load = value;
    });
  }

  _getSenderId() {
    int idSender = 0;
    DateTime date = null;
    _messageResponse.messages.forEach((messageItem) {
      if (_messageResponse.myData.id != messageItem.person.id &&
          (date == null || date.isBefore(messageItem.messageDate))) {
        idSender = messageItem.id;
        date = messageItem.messageDate;
      }
    });
    return idSender;
  }
}
