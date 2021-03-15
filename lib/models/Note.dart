import 'package:flutter_map/flutter_map.dart';

class Note {
  int time;
  String nick;
  Marker marker;
  String note;

  Note({this.time, this.nick, this.marker, this.note});
}
