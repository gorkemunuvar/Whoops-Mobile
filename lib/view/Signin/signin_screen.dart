import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/view/Signin/components/body.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhiteColor,
      body: Body(),
    );
  }
}
