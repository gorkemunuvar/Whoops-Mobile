import 'package:flutter/material.dart';
import 'package:notes_on_map/Screens/Signup/components/body.dart';
import 'package:notes_on_map/constants.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhiteColor,
      body: Body(),
    );
  }
}
