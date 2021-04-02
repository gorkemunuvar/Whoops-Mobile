import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/models/chat_message_model.dart';

List<ChatMessage> messages = [
  ChatMessage(
    messageContent: "Yoo",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "Hello, Will",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "How have you been?",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "Hey Kriss, I am doing fine dude. wbu?",
    messageType: "sender",
  ),
  ChatMessage(
    messageContent: "ehhhh, doing OK.",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "Is there any thing wrong?",
    messageType: "sender",
  ),
  ChatMessage(
    messageContent: "Hello, Will",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "How have you been?",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "Hey Kriss, I am doing fine dude. wbu?",
    messageType: "sender",
  ),
  ChatMessage(
    messageContent: "ehhhh, doing OK.",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "Is there any thing wrong?",
    messageType: "sender",
  ),
  ChatMessage(
    messageContent: "Hello, Will",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "How have you been?",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "Hey Kriss, I am doing fine dude. wbu?",
    messageType: "sender",
  ),
  ChatMessage(
    messageContent: "ehhhh, doing OK.",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "Is there any thing wrong?",
    messageType: "sender",
  ),
  ChatMessage(
    messageContent: "Hello, Will",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "How have you been?",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "Hey Kriss, I am doing fine dude. wbu?",
    messageType: "sender",
  ),
  ChatMessage(
    messageContent: "ehhhh, doing OK.",
    messageType: "receiver",
  ),
  ChatMessage(
    messageContent: "Is there any thing wrong?",
    messageType: "sender",
  ),
];

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _MessagesListView(),
        ),
        _MessageBoxTextField()
      ],
    );
  }
}

class _MessagesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      //physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _MessageBubble(chatMessage: messages[index]);
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage chatMessage;

  _MessageBubble({@required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.0),
      child: Align(
        alignment: (chatMessage.messageType == "receiver"
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Column(
          crossAxisAlignment: chatMessage.messageType == "receiver"
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (chatMessage.messageType == "receiver"
                    ? Colors.grey.shade200
                    : Colors.blue[200]),
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                chatMessage.messageContent,
                style: TextStyle(
                    fontSize: 15,
                    color: chatMessage.messageType == "receiver"
                        ? kPrimaryDarkColor
                        : kPrimaryWhiteColor),
              ),
            ),
            SizedBox(height: 2.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Text(
                '15 Tem 22:15',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageBoxTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
      height: 60,
      width: double.infinity,
      color: kPrimaryWhiteColor,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: kPrimaryDarkColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Mesajınızı buraya yazazabilirsiniz...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 18,
            ),
            backgroundColor: kPrimaryDarkColor,
            elevation: 0,
          ),
        ],
      ),
    );
  }
}
