import 'package:flutter/material.dart';
import 'package:notes_on_map/Screens/Map/components/body.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
