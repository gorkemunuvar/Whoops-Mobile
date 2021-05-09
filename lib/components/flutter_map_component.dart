import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:notes_on_map/services/stream_socket.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:notes_on_map/modals/whoop_modal.dart';

StreamSocket streamSocket = StreamSocket();

class FlutterMapComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    streamSocket.listen(kServerUrl);

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
                  var whoopData = jsonDecode(snapshot.data)['whoops'] as List;

                  List<Marker> markers = [];
                  //List<Whoop> whoops = [];

                  for (var item in whoopData) {
                    double latitude = double.parse(item['latitude']);
                    double longitude = double.parse(item['longitude']);
                    //String whoopTitle = item['whoop_title'];
                    //int time = int.parse(item['time']);

                    //Whoop whoop = Whoop(whoopTitle, latitude, longitude, time);

                    LatLng latLng = LatLng(latitude, longitude);
                    Marker marker = Marker(
                      anchorPos: AnchorPos.align(AnchorAlign.center),
                      height: 30,
                      width: 30,
                      point: latLng,
                      builder: (ctx) => Icon(Icons.pin_drop),
                    );

                    markers.add(marker);
                    //whoops.add(whoop);
                  }

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
