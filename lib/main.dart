import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
      'https://733ff5192744.ngrok.io',
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
  String url = 'https://733ff5192744.ngrok.io/sharenote';

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    'nick': 'test',
    'latitude': '46.15789',
    'longitude': '54.78964',
    'note': 'What up?',
    'time': '5',
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
  @override
  void initState() {
    super.initState();

    connectAndListen();
    print('connectAndListen func. worked.');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 1,
            child: TextButton(
                onPressed: makePostRequest, child: Text('Click Me'))),
        Expanded(
          flex: 4,
          child: StreamBuilder(
            stream: streamSocket.getResponse,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('snapshot.hasError'));
              } else {
                if (snapshot.data != null) {
                  print('If scope worked.');

                  print(snapshot.data);
                  /* var data = jsonDecode(snapshot.data)["notes"] as List;
                  print(data); */

                  return Center(child: Text(snapshot.data.toString()));
                }
              }

              return Center(child: Text('No data right now.'));
            },
          ),
        ),
      ],
    );
  }
}
