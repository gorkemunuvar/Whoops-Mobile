import 'whoop_service.dart';
import 'dart:convert' as convert;
import 'package:whoops/constants.dart';
import 'package:http/http.dart' as http;
import 'package:whoops/model/user_model.dart';
import 'package:whoops/model/whoop_model.dart';

class UserService {
  static Future<User> getUser(String accessToken) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(
      '$kServerUrl/user',
      headers: headers,
    );
    dynamic userJson = convert.jsonDecode(response.body);

    return User.fromJson(userJson);
  }

  static Future<User> getMyProfile(String accessToken) async {
    User user = await getUser(accessToken);

    //Get the whoops list here related to the user using WhoopService.
    String userId = user.id;
    List<Whoop> whoops = await WhoopService.getWhoops(accessToken, userId);

    user.whoops = whoops;

    return user;
  }

  static Future<void> updateAccount(String body, String accessToken) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.put(
      '$kServerUrl/user',
      headers: headers,
      body: body,
    );

    print(response.body);
  }
}
