import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/view/Settings/components/body.dart';

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
    );
  }
}
