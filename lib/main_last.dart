import 'dart:async';
import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
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
      home: HomePage() /* BuildWithSocketStream() */,
    );
  }
}

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen() {
  IO.Socket socket = IO.io(
      'http://97e1b67d5080.ngrok.io',
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
  String url = 'http://97e1b67d5080.ngrok.io/sharenote';

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    'nick': 'test',
    'latitude': '46.15789',
    'longitude': '54.78964',
    'note': 'What up?',
    'time': '100',
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
  final PopupController _popupController = PopupController();

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }

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

  void testFunction() {
    /* Map<String, List> map = {
      "topping": [
        {"id": "5001", "type": "None"},
        {"id": "5002", "type": "Glazed"},
        {"id": "5005", "type": "Sugar"},
        {"id": "5007", "type": "Powdered Sugar"},
        {"id": "5006", "type": "Chocolate with Sprinkles"},
        {"id": "5003", "type": "Chocolate"},
        {"id": "5004", "type": "Maple"}
      ]
    }; */

    Map<String, String> map = {
      "name": "John Smith",
      "email": "john@example.com"
    };

    //don't use map.toString()
    String str = jsonEncode(map);

    Map<String, dynamic> user = jsonDecode(str);

    print('Howdy, ${user['name']}!');
    print('We sent the verification link to ${user['email']}.');
  }

  @override
  void initState() {
    super.initState();

    connectAndListen();
  }

  List<Marker> markers = List<Marker>();

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
      future: getCurrentLocation(),
      builder: (context, snapshot) {
        Position currentPos = snapshot.data;

        Marker currentMarker = createMarker(
          currentPos.latitude,
          currentPos.longitude,
        );

        markers.add(currentMarker);

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              makePostRequest();
            },
          ),
          body: StreamBuilder(
              stream: streamSocket.getResponse,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasError) {
                  return Text('snapshot.hasError');
                } else {
                  //print('SnapShot Data: ${snapshot.data[0]}');

                  //Snapshoutdu aykıla lat long degerini al.

                  //testFunction();

                  //print("snapshot");
                  //print(snapshot.data);

                  if (snapshot.data != null) {
                    /* List list = List<Map<String, dynamic>>.from(
                        json.decode(snapshot.data)['notes']);

                    final jsonResponse =
                        jsonDecode(snapshot.data)['notes'] as List;

                    var data = json.decode(snapshot.data);
                    //print(data); */

                    print(snapshot.data);
                    var data = jsonDecode(snapshot.data)["notes"] as List;
                    print(data);

                    //var rest = data["notes"] as List;
                    //print(jsonResponse);

                    print("if worked.");
                  }

                  //var rest = data["notes"] as List;

                  /*List<Note> list =
                      rest.map<Note>((json) => Note.fromJson(json)).toList();

                  print(list); */

                  /* var noteObjsJson = jsonDecode(snapshot.data)['notes'] as List;
                  List<Note> noteObjs = noteObjsJson
                      .map((noteJson) => Note.fromJson(noteJson))
                      .toList(); */

                  //print('noteObjs: $noteObjs');R

                  /* Map<String, dynamic> json = jsonDecode(
                    snapshot.data[0].toString(),
                  );

                  //lat lang ile createMarker kullan.
                  double lat = double.parse(json['latitude']);
                  double lng = double.parse(json['longitude']);

                  print('snap lat : $lat');
                  print('snap lng : $lng'); */

                  //markes.add(newMarker);

                  return FlutterMap(
                    options: MapOptions(
                      //center: points[0],
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
                  );
                }
              }),
        );
      },
    );
  }
}

class Note {
  String latitude;
  String longitude;

  Note({
    this.latitude,
    this.longitude,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"],
        content: json["content"]);
  }
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
