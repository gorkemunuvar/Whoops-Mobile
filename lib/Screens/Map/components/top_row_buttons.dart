import 'map_search_delegate.dart';
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
          child: IconButton(
            icon: Icon(Icons.search_rounded),
            iconSize: 35,
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: MapSearchDelegate(),
              );
            },
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
              iconSize: 30.0,
              onPressed: () => Navigator.pushNamed(context, '/timeline'),
            ),
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
                onPressed: () {
                  Navigator.pushNamed(context, '/myProfile');
                },
              ),
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.people_alt_rounded,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/otherUsers');
                },
              ),
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.message,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/messages');
                },
              ),
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.settings,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
