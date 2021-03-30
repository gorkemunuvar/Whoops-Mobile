import 'components/body.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'components/messages_search_delegate.dart';

class AllMessagesScreen extends StatefulWidget {
  @override
  _AllMessagesScreenState createState() => _AllMessagesScreenState();
}

class _AllMessagesScreenState extends State<AllMessagesScreen> {
  final List<String> users = [
    "Aslı",
    "Görkem",
    "Burcu",
    "Ahmet",
    "Mami",
    "Turgut",
    "Gizem",
  ];

  String query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhiteColor,
      appBar: _buildAppBar(),
      body: Body(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryDarkColor,
      title: Text('Mesajlar'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            final String selected = await showSearch(
              context: context,
              delegate: MessagesSearchDelegate(users),
            );

            if (selected != null && selected != query) {
              setState(() {
                query = selected;
              });
            }
          },
        )
      ],
    );
  }
}
