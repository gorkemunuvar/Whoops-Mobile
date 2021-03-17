import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:notes_on_map/services/testing.dart';
import 'package:notes_on_map/services/Networking.dart';
import 'package:notes_on_map/services/StreamSocket.dart';
import 'package:notes_on_map/Screens/Map/components/map_widget.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class Body extends StatelessWidget {
  List<Marker> getMarkers(String json) {
    var data = jsonDecode(json)["notes"] as List;

    List<Marker> markers = [];

    for (var item in data) {
      double latitude = double.parse(item['latitude']);
      double longitude = double.parse(item['longitude']);

      LatLng latLng = LatLng(latitude, longitude);

      Marker marker = Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: latLng,
        builder: (ctx) => Icon(Icons.pin_drop),
      );

      markers.add(marker);
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    Testing test = Testing();
    Networking networking = Networking();
    StreamSocket streamSocket = StreamSocket();

    String url = 'https://a12c68a2a3b0.ngrok.io';
    final PopupController popupController = PopupController();

    streamSocket.listen(url);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: Icon(Icons.add, size: 30.0),
        backgroundColor: Colors.black,
        onPressed: () {
          networking.post('$url/sharenote', test.createRandomJson());
        },
      ),
      body: StreamBuilder(
        stream: streamSocket.getResponse,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('snapshot.hasError'));
          } else {
            if (snapshot.data != null) {
              return FlutterMapWidget(
                markers: getMarkers(snapshot.data),
                popupController: popupController,
              );
            }
          }

          return FlutterMapWidget(
            markers: [],
            popupController: popupController,
          );
        },
      ),
    );
  }
}
