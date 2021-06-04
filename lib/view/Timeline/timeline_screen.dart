import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'components/whoop_search_delegate.dart';
import 'package:whoops/view/Timeline/components/body.dart';

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
