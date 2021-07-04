import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:whoops/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import "package:latlong/latlong.dart" as latLng;

class FlutterMapWidget extends StatefulWidget {
  final List<Marker> markers;
  final double mapZoom;
  final LatLng centerLocation;

  FlutterMapWidget({
    this.markers,
    this.mapZoom = 3,
    this.centerLocation,
  });

  @override
  _FlutterMapWidgetState createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: widget.centerLocation,
        maxZoom: 18,
        zoom: widget.mapZoom,
        plugins: [
          MarkerClusterPlugin(),
        ],
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerClusterLayerOptions(
          maxClusterRadius: 120,
          disableClusteringAtZoom: 6,
          size: Size(28, 28),
          anchor: AnchorPos.align(AnchorAlign.bottom),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: widget.markers,
          polygonOptions: PolygonOptions(
            borderColor: kPrimaryDarkColor,
            color: kPrimaryDarkColor,
            borderStrokeWidth: 2,
          ),
          builder: (context, markers) {
            return FloatingActionButton(
              child: Text(markers.length.toString()),
              onPressed: null,
            );
          },
        ),
      ],
    );
  }
}
