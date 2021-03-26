import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double height;

  ButtonComponent({
    this.text,
    this.textColor,
    this.backgroundColor,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 5,
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
