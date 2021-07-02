import 'package:http/http.dart' as http;

//Reverse geocoding generates an address from a latitude and longitude.
class ReverseGeocoding {
  static Future<http.Response> getAdress(
      double latitude, double longitude) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    http.Response response = await http.get(
      'https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json&zoom=10',
      headers: headers,
    );

    return response;
  }
}
