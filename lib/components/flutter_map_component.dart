import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:notes_on_map/services/StreamSocket.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

StreamSocket streamSocket = StreamSocket();

class FlutterMapComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    streamSocket.listen('https://bcb9718efedd.ngrok.io');

    final PopupController _popupController = PopupController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 9,
          child: StreamBuilder(
            stream: streamSocket.getResponse,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('snapshot.hasError'));
              } else {
                if (snapshot.data != null) {
                  var data = jsonDecode(snapshot.data)["notes"] as List;

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

                  print(markers.length);

                  return _FlutterMapWidget(
                    markers: markers,
                    popupController: _popupController,
                  );
                }
              }

              return _FlutterMapWidget(
                markers: [],
                popupController: _popupController,
              );

              //return Center(child: Text('No data right now.'));
            },
          ),
        ),
      ],
    );
  }
}

class _FlutterMapWidget extends StatelessWidget {
  final List<Marker> markers;
  final PopupController popupController;

  _FlutterMapWidget({this.markers, this.popupController});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        //center: points[0],
        maxZoom: 18,
        zoom: 3,
        plugins: [
          MarkerClusterPlugin(),
        ],
        onTap: (_) =>
            // Hide popup when the map is tapped.
            popupController.hidePopup(),
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
          markers: markers,
          polygonOptions: PolygonOptions(
            borderColor: kPrimaryDarkColor,
            color: kPrimaryDarkColor,
            borderStrokeWidth: 2,
          ),
          popupOptions: PopupOptions(
            popupSnap: PopupSnap.top,
            popupController: popupController,
            popupBuilder: (_, marker) => _PopupWidget(),
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

class _PopupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      //color: kPrimaryWhiteColor,
      decoration: BoxDecoration(
        color: kPrimaryWhiteColor,
        border: Border.all(
          color: kPrimaryWhiteColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      //height: 80,
      child: GestureDetector(
        onTap: () => debugPrint("Popup tap!"),
        child: Padding(
          padding: EdgeInsets.all(3.0),
          child: Text(
            "I'm gonna leave a note here comming soon...",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Robott',
            ),
          ),
        ),
      ),
    );
  }
}
