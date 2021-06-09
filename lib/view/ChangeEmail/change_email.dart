import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/view/ChangeEmail/components/body.dart';

class ChangeEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: kPrimaryWhiteColor,
      body: Body(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryDarkColor,
      title: Text(
        'E-posta adresini değiştir',
        style: TextStyle(color: kPrimaryWhiteColor),
      ),
    );
  }
}
