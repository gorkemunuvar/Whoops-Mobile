import 'dart:convert';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/models/whoop_model.dart';
import 'package:http/http.dart' as http;

String _url = '$kServerUrl/whoop/share';

class WhoopService {
  static void share(Whoop whoop, String accessToken) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    String whoopJson = jsonEncode(whoop.toJson());

    http.post(_url, headers: headers, body: whoopJson).then((response) {
      print('WhoopServise.share() STATUS CODE:${response.statusCode}');
      print(response.body);
    });
  }

  static Future<List<Whoop>> getWhoops(
      String accessToken, String userId) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(
      '$kServerUrl/whoops/$userId',
      headers: headers,
    );

    List<dynamic> whoopsJsonList = jsonDecode(response.body) as List;
    List<Whoop> whoops = [];

    for (dynamic whoopJson in whoopsJsonList) {
      Whoop whoop = Whoop.fromJson(whoopJson);
      whoops.add(whoop);
    }

    return whoops;
  }
}
