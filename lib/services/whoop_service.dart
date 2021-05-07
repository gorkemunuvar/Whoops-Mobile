import 'dart:convert';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/modals/whoop_modal.dart';
import 'package:http/http.dart' as http;

String _url = '$kServerUrl/whoop/share';

class WhoopService {
  static void share(Whoop whoop) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      'nick': 'görkem',
      'note': whoop.whoopTitle,
      'latitude': whoop.latitude,
      'longitude': whoop.longitude,
      'time': whoop.time,
    };

    http.post(_url, headers: headers, body: json.encode(body)).then((response) {
      print('WhoopServise.share() STATUS CODE:${response.statusCode}');
    });
  }
}
