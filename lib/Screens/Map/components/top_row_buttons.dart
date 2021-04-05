import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';

//Top buttons on the map screen
class TopRowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 45.0,
          height: 45.0,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            child: Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.navigation),
              onPressed: () {},
              iconSize: 30.0,
            ),
            IconButton(
              icon: Icon(Icons.timeline),
              onPressed: () {},
              iconSize: 30.0,
            ),
            /* IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                print('Tapped menu icon.');
              },
              iconSize: 30.0,
            ), */
            _AnimatedColumnButtons(),
          ],
        )
      ],
    );
  }
}

class _AnimatedColumnButtons extends StatefulWidget {
  @override
  _AnimatedContentExampleState createState() => _AnimatedContentExampleState();
}

class _AnimatedContentExampleState extends State<_AnimatedColumnButtons> {
  double _animatedHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.menu,
            size: 35.0,
            color: kPrimaryDarkColor,
          ),
          onPressed: () {
            setState(() {
              _animatedHeight != 0.0
                  ? _animatedHeight = 0.0
                  : _animatedHeight = 500.0;
            });
          },
        ),
        AnimatedContainer(
          height: _animatedHeight,
          //width: 100.0,
          duration: Duration(milliseconds: 0),
          child: Column(
            children: [
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.person,
                ),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.people_alt_rounded,
                ),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.message,
                  //size: 35.0,
                ),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.settings,
                ),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
