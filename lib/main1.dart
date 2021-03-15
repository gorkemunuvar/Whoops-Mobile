import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Street Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PopupController _popupController = PopupController();

  int pointIndex;

  List points = [
    LatLng(51.5, -0.09),
    LatLng(49.8566, 3.3522),
  ];

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }

  Future<List<Marker>> getMarkers() async {
    Position position = await getCurrentLocation();

    LatLng latLng = LatLng(position.latitude, position.longitude);

    List<Marker> markers = List<Marker>();

    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: points[pointIndex],
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(49.8566, 3.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: latLng,
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
    ];

    return markers;
  }

  @override
  void initState() {
    pointIndex = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [
        Marker(
          anchorPos: AnchorPos.align(AnchorAlign.center),
          height: 30,
          width: 30,
          point: LatLng(48.8566, 2.3522),
          builder: (ctx) => Icon(Icons.pin_drop),
        ),
      ],
      future: getMarkers(),
      builder: (context, snapshot) {
        List<Marker> markers = snapshot.data;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              pointIndex++;

              if (pointIndex >= points.length) {
                pointIndex = 0;
              }

              setState(() {
                markers[0] = Marker(
                  point: points[pointIndex],
                  anchorPos: AnchorPos.align(AnchorAlign.center),
                  height: 30,
                  width: 30,
                  builder: (ctx) => Icon(Icons.pin_drop),
                );

                // one of this
                markers = List.from(markers);
                // markers = [...markers];
                // markers = []..addAll(markers);
              });
            },
          ),
          body: FlutterMap(
            options: MapOptions(
              center: points[0],
              maxZoom: 18,
              zoom: 3,
              plugins: [
                MarkerClusterPlugin(),
              ],
              onTap: (_) => _popupController
                  .hidePopup(), // Hide popup when the map is tapped.
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                    popupController: _popupController,
                    popupBuilder: (_, marker) => Container(
                          width: 150,
                          height: 80,
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () => debugPrint("Popup tap!"),
                            child: Text(
                              "I'm gonna leave a note here comming soon and you can see what i do here!!",
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
          ),
        );
      },
    );
  }
}
