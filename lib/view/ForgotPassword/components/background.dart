import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({@required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: size.height,
        child: child,
      ),
    );
  }
}
