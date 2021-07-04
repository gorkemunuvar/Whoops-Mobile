import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:provider/provider.dart';
import 'package:whoops/model/whoop_model.dart';
import 'package:whoops/controller/stream_socket.dart';
import 'package:whoops/provider/whoops_provider.dart';
import 'package:whoops/view/utils/flutter_map_widget.dart';

import 'package:whoops/controller/location_service.dart';

//LatLng currentLocation;
StreamSocket streamSocket = StreamSocket();

class FlutterMapComponent extends StatefulWidget {
  @override
  _FlutterMapComponentState createState() => _FlutterMapComponentState();
}

Future<LatLng> _currentLocation;

class _FlutterMapComponentState extends State<FlutterMapComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentLocation = LocationService.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    streamSocket.listen(kServerUrl);

    final PopupController _popupController = PopupController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 9,
          child: FutureBuilder(
            future: _currentLocation,
            builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  print('done worked.');
                  return MapStreamBuilder(centerLocation: snapshot.data);

                default:
                  print('default worked.');
                  return MapStreamBuilder();
              }
            },
          ),
        ),
      ],
    );
  }
}

class MapStreamBuilder extends StatelessWidget {
  final LatLng centerLocation;

  MapStreamBuilder({this.centerLocation});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamSocket.getResponse,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('snapshot.hasError'));
        } else {
          if (snapshot.data != null) {
            var whoopJsonList = jsonDecode(snapshot.data)['whoops'] as List;
            print(whoopJsonList);

            List<Whoop> whoops = whoopJsonList
                .map((whoopJson) => Whoop.fromJson(whoopJson))
                .toList();

            List<Marker> markers = whoops.map((whoop) {
              return Marker(
                anchorPos: AnchorPos.align(AnchorAlign.center),
                height: 40.0,
                width: 200.0,
                point: LatLng(whoop.latitude, whoop.longitude),
                builder: (ctx) => _CustomMarkerContent(
                  whoopTitle: whoop.title,
                ),
              );
            }).toList();

            Provider.of<WhoopsProvider>(context, listen: true)
                .updateWhoops(whoops);

            return FlutterMapWidget(
              markers: markers,
              mapZoom: 7,
              centerLocation: centerLocation,
            );
          }
        }

        return FlutterMapWidget(
          markers: [],
          mapZoom: 7,
          centerLocation: centerLocation,
        );
      },
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
