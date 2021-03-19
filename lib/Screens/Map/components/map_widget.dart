import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:notes_on_map/services/CurrentLocation.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class FlutterMapWidget extends StatefulWidget {
  final List<Marker> markers;

  FlutterMapWidget({this.markers});

  @override
  _FlutterMapWidgetState createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  CurrentLocation _cLocation = CurrentLocation();
  Future<LatLng> _currentLocation;

  @override
  void initState() {
    super.initState();
    _currentLocation = _cLocation.get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _currentLocation,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            print('Done');
            return _buildFlutterMap(snapshot.data, 15);
          default:
            print('Not Done');
            return _buildFlutterMap(null, 4);
        }
      },
    );
  }

  Widget _buildFlutterMap(LatLng location, double zoomLevel) {
    PopupController popupController = PopupController();

    return FlutterMap(
      key: UniqueKey(),
      options: MapOptions(
        zoom: zoomLevel,
        minZoom: 4,
        maxZoom: 18,
        center: location,
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
          markers: widget.markers,
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
