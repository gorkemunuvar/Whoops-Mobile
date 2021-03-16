import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

void connectAndListen() {
  IO.Socket socket = IO.io(
      'https://30f7b38442e2.ngrok.io',
      IO.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  socket.onConnect((_) {
    print('connected to the server :)');

    //When an event recieved from server, data is added to the stream
    socket.on(
      'user_event',
      (data) {
        streamSocket.addResponse(data.toString());
      },
    );
  });

  socket.onDisconnect((_) => print('disconnect'));
}

void makePostRequest() async {
  //Change the URL when ngrok is started again.
  String url = 'https://30f7b38442e2.ngrok.io/sharenote';

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Random random = Random();

  final body = jsonEncode({
    'nick': 'test',
    'latitude': '${random.nextInt(90)}.1578',
    'longitude': '${random.nextInt(90)}.7896',
    'note': 'What up?',
    'time': '${random.nextInt(30)}',
  });

  http.Response response = await http.post(
    url,
    headers: headers,
    body: body,
  );

  print('Response status: ${response.statusCode}');
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Marker createMarker(double latitude, double longitude) {
    LatLng latLng = LatLng(latitude, longitude);

    return Marker(
      anchorPos: AnchorPos.align(AnchorAlign.center),
      height: 30,
      width: 30,
      point: latLng,
      builder: (ctx) => Icon(Icons.pin_drop),
    );
  }

  @override
  void initState() {
    super.initState();

    connectAndListen();
    print('connectAndListen func. worked.');
  }

  @override
  Widget build(BuildContext context) {
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
                  print('If scope worked.');

                  //print(snapshot.data);
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

                  return FlutterMapWidget(
                    markers: markers,
                    popupController: _popupController,
                  );
                }
              }

              return FlutterMapWidget(
                markers: [],
                popupController: _popupController,
              );

              //return Center(child: Text('No data right now.'));
            },
          ),
        ),
        Expanded(
            flex: 1,
            child: TextButton(
                onPressed: makePostRequest,
                child: Text(
                  'Click Me',
                  style: TextStyle(fontSize: 20),
                ))),
      ],
    );
  }
}

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
              popupBuilder: (_, marker) => Container(
                    width: 150,
                    height: 80,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () => debugPrint("Popup tap!"),
                      child: Text(
                          "I'm gonna leave a note here comming soon and you can see what i do here!!",
                          style: TextStyle(fontSize: 15)),
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
