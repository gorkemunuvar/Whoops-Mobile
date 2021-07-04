import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/view/ChangeUsername/components/body.dart';

class ChangeUsernameScreen extends StatelessWidget {
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
