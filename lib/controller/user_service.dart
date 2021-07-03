import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:whoops/constants.dart';

import 'package:notes_on_map/services/whoop_service.dart';

class UserService {
  static Future<User> getMyProfileUser(String accessToken) async {
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
