import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/Screens/Signin/components/body.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhiteColor,
      body: Body(),
    );
  }
}
