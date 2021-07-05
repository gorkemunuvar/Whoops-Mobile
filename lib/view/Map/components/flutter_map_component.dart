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

StreamSocket streamSocket = StreamSocket();

class FlutterMapComponent extends StatefulWidget {
  final MapController mapController;
  FlutterMapComponent(this.mapController);
  @override
  _FlutterMapComponentState createState() => _FlutterMapComponentState();
}

Future<LatLng> _currentLocation;

class _FlutterMapComponentState extends State<FlutterMapComponent> {
  MapController _mapController;
  @override
  void initState() {
    super.initState();
    _currentLocation = LocationService.getCurrentLocation();
    _mapController = widget.mapController;
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
              LatLng centerLocation =
                  LatLng(40.04145833569767, 29.11417283140674);
              if (snapshot.connectionState == ConnectionState.done) {
                centerLocation = snapshot.data;
                _mapController.move(centerLocation, 10);
              }
              return MapStreamBuilder(
                centerLocation: centerLocation,
                mapController: _mapController,
              );
            },
          ),
        ),
      ],
    );
  }
}

class MapStreamBuilder extends StatelessWidget {
  final LatLng centerLocation;
  final MapController mapController;
  MapStreamBuilder({this.centerLocation, this.mapController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamSocket.getResponse,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Marker> markers = [];
        if (snapshot.hasError) {
          return Center(child: Text('snapshot.hasError'));
        } else {
          if (snapshot.data != null) {
            var whoopJsonList = jsonDecode(snapshot.data)['whoops'] as List;
            print(whoopJsonList);

            List<Whoop> whoops = whoopJsonList
                .map((whoopJson) => Whoop.fromJson(whoopJson))
                .toList();

            markers = whoops.map((whoop) {
              return Marker(
                anchorPos: AnchorPos.align(AnchorAlign.center),
                height: 40.0,
                width: 200.0,
                point: LatLng(whoop.latitude, whoop.longitude),
                builder: (ctx) => _CustomMarkerContent(
                  whoopTitle: whoop.title,
                  whoopTag: whoop.tags,
                ),
              );
            }).toList();

            Provider.of<WhoopsProvider>(context, listen: true)
                .updateWhoops(whoops);
          }
        }

        return FlutterMapWidget(
          markers: markers,
          mapZoom: 7,
          centerLocation: centerLocation,
          mapController: mapController,
        );
      },
    );
  }
}

class _CustomMarkerContent extends StatefulWidget {
  final String whoopTitle;
  final List whoopTag;

  _CustomMarkerContent({this.whoopTitle, this.whoopTag});

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

  Image marker() {
    String asset = "assets/icons/whoop_markers";

    if (widget.whoopTag[0].contains("basket"))
      return Image.asset("$asset/basketball.png");
    else if (widget.whoopTag[0].contains("futbol"))
      return Image.asset("$asset/football.png");
    else if (widget.whoopTag[0].contains("voleybol"))
      return Image.asset("$asset/volleyball.png");
    else if (widget.whoopTag[0].contains("müzik"))
      return Image.asset("$asset/music.png");
    else if (widget.whoopTag[0].contains("müziği"))
      return Image.asset("$asset/guitar.png");
    else if (widget.whoopTag[0].contains("dans"))
      return Image.asset("$asset/dance.png");

    return Image.asset("$asset/marker.png");
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
