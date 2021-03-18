import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class FlutterMapWidget extends StatelessWidget {
  final List<Marker> markers;
  final PopupController popupController;

  FlutterMapWidget({this.markers, this.popupController});

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
            popupController.hidePopup(), // Hide popup when the map is tapped.
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
