import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/screens/Settings/components/body.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: kPrimaryWhiteColor,
      body: Body(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: kPrimaryDarkColor,
      title: Text(
        'Ayarlar',
        style: TextStyle(color: kPrimaryWhiteColor),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.done,
            color: Colors.white,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
