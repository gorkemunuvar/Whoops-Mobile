import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/screens/ForgotPassword/components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryDarkColor,
        title: Text('Şifremi Unuttum',
            style: TextStyle(color: kPrimaryLightColor)),
        leading: Icon(Icons.arrow_back),
      ),
      backgroundColor: kPrimaryWhiteColor,
      body: Body(),
    );
  }
}
