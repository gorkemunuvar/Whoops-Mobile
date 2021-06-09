import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation {
  Future<LatLng> get() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng location = LatLng(position.latitude, position.longitude);
    return location;
  }
}
