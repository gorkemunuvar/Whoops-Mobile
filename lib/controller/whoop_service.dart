import 'dart:convert';
import 'package:whoops/constants.dart';
import 'package:whoops/model/whoop_model.dart';
import 'package:http/http.dart' as http;

String _url = '$kServerUrl/whoop/share';

class WhoopService {
  static void share(Whoop whoop, String accessToken) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      'title': whoop.title,
      'latitude': whoop.latitude,
      'longitude': whoop.longitude,
      'time': whoop.time,
    };

    http.post(_url, headers: headers, body: json.encode(body)).then((response) {
      print('WhoopServise.share() STATUS CODE:${response.statusCode}');
      print(response.body);
    });
  }
}
