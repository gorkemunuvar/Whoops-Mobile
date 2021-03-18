import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:notes_on_map/services/StreamSocket.dart';
import 'package:notes_on_map/Screens/Map/components/map_widget.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:notes_on_map/screens/Map/components/bottom_sheet_modal.dart';
import 'package:notes_on_map/services/CurrentLocation.dart';

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

class Body extends StatelessWidget {
  void showBottomSheetModal({BuildContext context}) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return BottomSheetModal();
      },
    );
  }

  void getCurrentLocation() async {
    CurrentLocation currentLocation = CurrentLocation();
    Position position = await currentLocation.get();

    print('Latitude: ${position.latitude} Longitude ${position.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    StreamSocket streamSocket = StreamSocket();

    String url = 'https://fef9ad34cafb.ngrok.io';
    final PopupController popupController = PopupController();

    getCurrentLocation();
    streamSocket.listen(url);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: Icon(Icons.record_voice_over, size: 30.0),
        backgroundColor: Colors.black,
        onPressed: () {
          showBottomSheetModal(context: context);
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
