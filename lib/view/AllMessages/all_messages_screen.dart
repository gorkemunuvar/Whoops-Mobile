import 'components/body.dart';
import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'components/messages_search_delegate.dart';

class AllMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhiteColor,
      appBar: _buildAppBar(context),
      body: Body(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryDarkColor,
      title: Text('Mesajlar'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            await showSearch(
              context: context,
              delegate: MessagesSearchDelegate(),
            );
          },
        )
      ],
    );
  }
}
