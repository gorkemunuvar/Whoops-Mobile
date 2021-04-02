import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/models/chat_message_model.dart';

List<ChatMessage> messages = [
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
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          //physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding:
                  EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
              child: Align(
                alignment: (messages[index].messageType == "receiver"
                    ? Alignment.topLeft
                    : Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (messages[index].messageType == "receiver"
                        ? Colors.grey.shade200
                        : Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    messages[index].messageContent,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
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
                        hintStyle: TextStyle(color: Colors.black54),
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
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
