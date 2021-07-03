import 'whoop_service.dart';
import 'dart:convert' as convert;
import 'package:whoops/constants.dart';
import 'package:http/http.dart' as http;
import 'package:whoops/model/user_model.dart';
import 'package:whoops/model/whoop_model.dart';

class UserService {
  static Future<User> getMyProfileUser(String accessToken) async {
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

    //Get the whoops list here related to the user using WhoopService.
    String userId = userJson['id'];
    List<Whoop> whoops = await WhoopService.getWhoops(accessToken, userId);

    User user = User.fromJson(userJson);
    user.whoops = whoops;

    return user;
  }
}
