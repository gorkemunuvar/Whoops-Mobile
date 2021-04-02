import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

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
