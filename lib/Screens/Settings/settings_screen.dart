import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/screens/Settings/components/body.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        backgroundColor: kPrimaryDarkColor,
        title: Text('Ayarlar', style: TextStyle(color: kPrimaryLightColor)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: kPrimaryWhiteColor,
      body: Body(),
    );
  }
}
