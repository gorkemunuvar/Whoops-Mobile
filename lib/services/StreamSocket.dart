import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class StreamSocket {
  var _socketResponse = StreamController<String>();
  Stream<String> get getResponse => _socketResponse.stream;
  void Function(String) get addResponse => _socketResponse.sink.add;

  void dispose() {
    _socketResponse.close();
  }

  void listen(String url) {
    IO.Socket socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    socket.onConnect((_) {
      print('connected to the server.');

      //When an event recieved from server, data is added to the stream
      socket.on(
        'user_event',
        (data) {
          addResponse(data.toString());
        },
      );
    });

    socket.onDisconnect((_) => print('Disconnected.'));
  }
}
