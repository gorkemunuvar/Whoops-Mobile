import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: Stack(
          children: [
            Positioned(
              top: -225,
              left: size.width / 2,
              child: SvgPicture.asset('assets/images/signin_top.svg'),
            ),
            child
          ],
        ),
      ),
    );
  }
}
