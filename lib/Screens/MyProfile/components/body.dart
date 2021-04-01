import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/components/whoop_card.dart';
import 'package:notes_on_map/components/circle_avatar_component.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //Main Column
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 200,
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
          SizedBox(height: 5),
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
              SizedBox(height: 18),
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
            ],
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return WhoopCard(title: items[index].toString());
              },
            ),
          ),
        ],
      ),
    );
  }

  final items = List<String>.generate(10000, (i) => "Item $i");
}

class FlutterMapComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      //key: UniqueKey(),
      options: MapOptions(
        zoom: 5 /* zoomLevel */,
        minZoom: 4,
        maxZoom: 18,
        center: LatLng(38.9573, 35.2407) /* location */,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
      ],
    );
  }
}
