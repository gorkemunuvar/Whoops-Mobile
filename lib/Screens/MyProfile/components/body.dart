import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/components/whoop_card.dart';
import 'package:notes_on_map/components/circle_avatar_component.dart';
import 'package:notes_on_map/components/flutter_map_component.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = true;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: kPrimaryWhiteColor,
          pinned: _pinned,
          snap: _snap,
          floating: _floating,
          expandedHeight: 350.0,
          flexibleSpace: _buildFlexibleSpaceBar(),
        ),
        _buildSliverList(),
      ],
    );
  }

  //List of Whoop Cards
  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            color: kPrimaryWhiteColor,
            //height: 100.0,
            child: Center(
              child: WhoopCard(
                title: index.toString(),
                havePicture: false,
              ),
            ),
          );
        },
        childCount: 20,
      ),
    );
  }

  Widget _buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      background: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 250,
                  child: FlutterMapComponent(),
                ),
                Positioned(
                  bottom: -60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatarComponent(
                        radius: 40,
                        borderSize: 42,
                      ),
                      SizedBox(height: 5),
                      Text(
                        '@asligamze',
                        style: TextStyle(
                          color: kPrimaryDarkColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          //Info column
          Column(
            children: [
              //Row for texts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('3 Whoops', style: TextStyle(color: kPrimaryDarkColor)),
                  SizedBox(),
                  Text('Kayseri, TR',
                      style: TextStyle(color: kPrimaryDarkColor)),
                ],
              ),
              SizedBox(height: 15),
              //Row for icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(),
                  SizedBox(width: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Image.asset('assets/icons/twitter.png'),
                        iconSize: 30,
                        onPressed: () {},
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Image.asset('assets/icons/instagram.png'),
                        iconSize: 30,
                        onPressed: () {},
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Image.asset('assets/icons/facebook.png'),
                        iconSize: 26,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25),
              Text(
                'Whoop\'larım',
                style: TextStyle(
                  color: kPrimaryDarkColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
