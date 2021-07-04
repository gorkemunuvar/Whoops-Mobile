import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<LatLng> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng location = LatLng(position.latitude, position.longitude);
    return location;
  }
}
