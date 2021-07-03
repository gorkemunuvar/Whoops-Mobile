import 'package:flutter/foundation.dart';
import 'package:whoops/model/whoop_model.dart';

class WhoopsProvider extends ChangeNotifier {
  List<Whoop> _whoops = [];

  get whoops => _whoops;

  void updateWhoops(List<Whoop> whoopsStream) {
    _whoops = whoopsStream;
    notifyListeners();
  }
}
