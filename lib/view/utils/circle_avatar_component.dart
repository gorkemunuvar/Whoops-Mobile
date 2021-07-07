import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';

//This is for profile picture
class CircleAvatarComponent extends StatelessWidget {
  final double radius;
  final double borderSize;
  final ImageProvider<Object> backgroundImage;
  //final Image or String = 'assets/image.vsvs'

  CircleAvatarComponent({
    @required this.radius,
    this.borderSize,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return borderSize != null
        ? CircleAvatar(
            radius: radius + borderSize,
            backgroundColor: kPrimaryDarkColor,
            child: CircleAvatar(
              radius: radius,
              backgroundImage: backgroundImage,
            ),
          )
        : CircleAvatar(
            radius: radius,
            backgroundImage: backgroundImage,
          );
  }
}
