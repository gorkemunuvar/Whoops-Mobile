import 'components/body.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';

class AnotherUserScreen extends StatelessWidget {
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
      title: Text(
        '@aslıgamze',
        style: TextStyle(color: kPrimaryWhiteColor),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.message),
          onPressed: () {},
        )
      ],
    );
  }
}