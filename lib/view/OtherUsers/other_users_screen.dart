import 'package:flutter/cupertino.dart';
import 'components/body.dart';
import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'components/user_search_delegate.dart';

class OtherUsersScreen extends StatelessWidget {
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
      title: Text('Tüm Kullanıcılar'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            await showSearch(
              context: context,
              delegate: UserSearchDelegate(),
            );
          },
        )
      ],
    );
  }
}
