import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:notes_on_map/services/stream_socket.dart';
import 'package:notes_on_map/components/flutter_map_widget.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

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

                  print(whoopData);

                  List<Marker> markers = [];

                  for (var item in whoopData) {
                    double latitude = item['latitude'];
                    double longitude = item['longitude'];
                    String whoopTitle = item['title'];
                    //int time = int.parse(item['time']);

                    //Whoop whoop = Whoop(whoopTitle, latitude, longitude, time);

                    LatLng latLng = LatLng(latitude, longitude);

                    Marker marker = Marker(
                      anchorPos: AnchorPos.align(AnchorAlign.center),
                      height: 40.0,
                      width: 200.0,
                      point: LatLng(latitude, longitude),
                      builder: (ctx) =>
                          _CustomMarkerContent(whoopTitle: whoopTitle),
                    );

                    markers.add(marker);
                    //whoops.add(whoop);
                  }

                  return FlutterMapWidget(
                    markers: markers,
                    mapZoom: 4.8,
                    clusterOptions: true,
                  );
                }
              }

              return FlutterMapWidget(
                markers: [],
                mapZoom: 4.8,
                clusterOptions: true,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CustomMarkerContent extends StatefulWidget {
  final String whoopTitle;

  _CustomMarkerContent({this.whoopTitle});

  @override
  __CustomMarkerContentState createState() => __CustomMarkerContentState();
}

class __CustomMarkerContentState extends State<_CustomMarkerContent> {
  bool infoWindowVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          infoWindowVisible = !infoWindowVisible;
        });
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: marker(),
          ),
          Align(
            alignment: Alignment.center,
            child: popup(),
          ),
        ],
      ),
    );
  }

  Icon marker() {
    return Icon(
      Icons.pin_drop,
      size: 30.0,
    );
  }

  Visibility popup() {
    return Visibility(
      visible: infoWindowVisible,
      child: _PopupWidget(whoopTitle: widget.whoopTitle),
    );
  }
}

class _PopupWidget extends StatelessWidget {
  final String whoopTitle;

  _PopupWidget({this.whoopTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: kPrimaryWhiteColor,
      decoration: BoxDecoration(
        color: kPrimaryDarkColor,
        border: Border.all(
          color: kPrimaryWhiteColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(
          whoopTitle.length <= 50
              ? whoopTitle
              : '${whoopTitle.substring(0, 49)}...',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryWhiteColor,
            fontSize: 13,
            fontFamily: 'Robott',
          ),
        ),
      ),
    );
  }
}
