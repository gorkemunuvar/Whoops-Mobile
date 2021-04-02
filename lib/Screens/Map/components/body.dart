import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/components/flutter_map_component.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FlutterMapComponent(),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                backgroundColor: kPrimaryDarkColor,
                child: Icon(
                  Icons.add,
                  size: 30.0,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: FloatingActionButton(
                      backgroundColor: kPrimaryDarkColor,
                      child: Icon(
                        Icons.gps_fixed,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: FloatingActionButton(
                      backgroundColor: kPrimaryDarkColor,
                      child: Icon(
                        Icons.directions_walk,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: FloatingActionButton(
                      backgroundColor: kPrimaryDarkColor,
                      child: Icon(
                        Icons.add,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
