import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/view/ChangePassword/components/body.dart';

class ChangePasswordScreen extends StatelessWidget {
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
        'Şifremi Değiştir',
        style: TextStyle(color: kPrimaryWhiteColor),
      ),
    );
  }
}
