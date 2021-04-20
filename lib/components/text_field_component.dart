import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';

class TextFieldComponent extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function onChanged;

  TextFieldComponent({
    this.hintText,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
