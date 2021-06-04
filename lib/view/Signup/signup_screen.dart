import 'package:flutter/material.dart';
import 'package:whoops/view/Signup/components/body.dart';
import 'package:whoops/constants.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhiteColor,
      body: Body(),
    );
  }
}
