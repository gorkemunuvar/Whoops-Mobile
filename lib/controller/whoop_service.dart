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

    String whoopJson = jsonEncode(whoop.toJson());

    http.post(_url, headers: headers, body: whoopJson).then((response) {
      print('WhoopServise.share() STATUS CODE:${response.statusCode}');
      print(response.body);
    });
  }

  static Future<List<Whoop>> getWhoops(
    String accessToken,
    String userId,
  ) async {
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
    List<Whoop> whoops =
        whoopsJsonList.map((whoopJson) => Whoop.fromJson(whoopJson)).toList();

    return whoops;
  }

  static Future<List<Whoop>> getActiveWhoopsByTitle(
    String accessToken,
    String title,
  ) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(
      '$kServerUrl/whoops/title/$title',
      headers: headers,
    );

    List<dynamic> whoopsJsonList = jsonDecode(response.body) as List;
    List<Whoop> whoops =
        whoopsJsonList.map((whoopJson) => Whoop.fromJson(whoopJson)).toList();

    return whoops;
  }

  static Future<List<Whoop>> getActiveWhoopsByTag(
    String accessToken,
    String tag,
  ) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(
      '$kServerUrl/whoops/tag/$tag',
      headers: headers,
    );

    List<dynamic> whoopsJsonList = jsonDecode(response.body) as List;
    List<Whoop> whoops =
        whoopsJsonList.map((whoopJson) => Whoop.fromJson(whoopJson)).toList();

    return whoops;
  }

  static Future<List<Whoop>> getActiveWhoopsByUsername(
    String accessToken,
    String username,
  ) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(
      '$kServerUrl/whoops/username/$username',
      headers: headers,
    );

    List<dynamic> whoopsJsonList = jsonDecode(response.body) as List;
    List<Whoop> whoops =
        whoopsJsonList.map((whoopJson) => Whoop.fromJson(whoopJson)).toList();

    return whoops;
  }
}
