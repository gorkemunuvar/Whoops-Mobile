import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';

class TextFieldComponent extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  TextFieldComponent({
    this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: TextStyle(color: kPrimaryDarkColor),
      decoration: InputDecoration(
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
