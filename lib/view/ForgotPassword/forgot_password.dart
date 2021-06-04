import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/view/ForgotPassword/components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryDarkColor,
        title: Text(
          'Şifremi Unuttum',
          style: TextStyle(color: kPrimaryWhiteColor),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: kPrimaryWhiteColor,
      body: Body(),
    );
  }
}
