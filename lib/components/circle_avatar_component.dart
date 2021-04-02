import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';

//This is for profile picture
class CircleAvatarComponent extends StatelessWidget {
  final double radius;
  final double borderSize;
  //final Image or String = 'assets/image.vsvs'

  CircleAvatarComponent({@required this.radius, this.borderSize});

  @override
  Widget build(BuildContext context) {
    return borderSize != null
        ? CircleAvatar(
            radius: borderSize,
            backgroundColor: kPrimaryDarkColor,
            child: CircleAvatar(
              radius: radius,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          )
        : CircleAvatar(
            radius: radius,
            child: Image(image: AssetImage('assets/images/profile.png')),
          );
  }
}
