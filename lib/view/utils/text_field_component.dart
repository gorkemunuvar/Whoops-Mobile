import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';

class TextFieldComponent extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function onChanged;
  final TextEditingController controller;

  TextFieldComponent(
      {this.hintText,
      this.obscureText = false,
      this.onChanged,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      style: TextStyle(color: kPrimaryDarkColor),
      decoration: InputDecoration(
        fillColor: kPrimaryDarkColor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w300,
          color: Colors.grey,
          fontSize: 15.0,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
