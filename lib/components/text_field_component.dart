import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';

class TextFieldComponent extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  TextFieldComponent({
    this.hintText,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
