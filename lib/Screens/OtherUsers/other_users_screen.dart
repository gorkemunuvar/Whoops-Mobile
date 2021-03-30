import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/user_info_card.dart';
import 'components/user_search_delegate.dart';

class OtherUsersScreen extends StatefulWidget {
  @override
  _OtherUsersScreenState createState() => _OtherUsersScreenState();
}

class _OtherUsersScreenState extends State<OtherUsersScreen> {
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
      appBar: AppBar(
        title: Text('Tüm Kullanıcılar'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String selected = await showSearch(
                context: context,
                delegate: UserSearchDelegate(users),
              );

              if (selected != null && selected != query) {
                setState(() {
                  query = selected;
                });
              }
            },
          )
        ],
      ),
      body: Body(),
    );
  }
}
