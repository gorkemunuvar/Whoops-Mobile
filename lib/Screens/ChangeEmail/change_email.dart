import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/screens/ChangeEmail/components/body.dart';

class ChangeEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryDarkColor,
        title: Text('E-posta adresini değiştir',
            style: TextStyle(color: kPrimaryLightColor)),
        leading: Icon(Icons.arrow_back),
      ),
      backgroundColor: kPrimaryWhiteColor,
      body: Body(),
    );
  }
}
