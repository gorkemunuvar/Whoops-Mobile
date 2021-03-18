import 'package:geolocator/geolocator.dart';

class CurrentLocation {
  Future<Position> get() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }
}
