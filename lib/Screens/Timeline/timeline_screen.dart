import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'components/whoop_search_delegate.dart';
import 'package:notes_on_map/screens/Timeline/components/body.dart';

class TimelineScreen extends StatelessWidget {
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
      title: Text('Akış'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            await showSearch(
              context: context,
              delegate: WhoopSearchDelegate(),
            );
          },
        ),
      ],
    );
  }
}
