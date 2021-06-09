import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whoops/constants.dart';

import 'package:whoops/model/user_model.dart';

class UserService {
  static Future<User> getMyProfileUser(String accessToken) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(
      '$kServerUrl/user',
      headers: headers,
    );

    dynamic userMap = jsonDecode(response.body);
    return User.fromJson(userMap);
  }
}
