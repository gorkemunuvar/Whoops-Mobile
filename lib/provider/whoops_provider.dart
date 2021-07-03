import 'package:flutter/foundation.dart';
import 'package:notes_on_map/models/whoop_model.dart';

class WhoopsProvider extends ChangeNotifier {
  List<Whoop> _whoops = [];

  get whoops => _whoops;

  void updateWhoops(List<Whoop> whoopsStream) {
    _whoops = whoopsStream;
    notifyListeners();
  }
}
