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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            elevation: 0.0,
            child: Icon(Icons.location_pin, size: 30.0),
            backgroundColor: Colors.black,
            onPressed: () {
              //Focus Location;
            },
          ),
          FloatingActionButton(
            elevation: 0.0,
            child: Icon(Icons.record_voice_over, size: 30.0),
            backgroundColor: Colors.black,
            onPressed: () {
              showBottomSheetModal(context: context);
            },
          ),
        ],
      ),
      body: WidgetStreamBuilder(),
    );
  }
}

class WidgetStreamBuilder extends StatelessWidget {
  final StreamSocket streamSocket = StreamSocket();
  final String url = 'https://3940dcd92377.ngrok.io';

  @override
  Widget build(BuildContext context) {
    streamSocket.listen(url);

    print("_buildStreamBuilder worked.");

    return StreamBuilder(
      stream: streamSocket.getResponse,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Marker> markers = getMarkers(snapshot.data);
        return WidgetFlutterMap(zoomLevel: 5, markers: markers);
      },
    );
  }
}

class WidgetFlutterMap extends StatelessWidget {
  final double zoomLevel;
  final List<Marker> markers;

  WidgetFlutterMap({this.zoomLevel, this.markers});

  final PopupController popupController = PopupController();

  @override
  Widget build(BuildContext context) {
    print('_buildFlutterMap worked.');

    return FlutterMap(
      //key: UniqueKey(),
      options: MapOptions(
        zoom: zoomLevel,
        minZoom: 3,
        maxZoom: 18,
        center: LatLng(38.701336, 35.545097) /* location */,
        plugins: [
          MarkerClusterPlugin(),
        ],
        onTap: (_) => popupController.hidePopup(),
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
          anchor: AnchorPos.align(AnchorAlign.center),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: markers,
          polygonOptions: PolygonOptions(
              borderColor: Colors.red,
              color: Colors.black12,
              borderStrokeWidth: 3),
          popupOptions: PopupOptions(
              popupSnap: PopupSnap.top,
              popupController: popupController,
              popupBuilder: (_, marker) => Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(
                      width: 150,
                      height: 80,
                      child: GestureDetector(
                        onTap: () => debugPrint("Popup tap!"),
                        child: Text(
                            "I'm gonna leave a note here comming soon and you can see what i do here!!",
                            style: TextStyle(fontSize: 15)),
                      ),
                    ),
                  )),
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
