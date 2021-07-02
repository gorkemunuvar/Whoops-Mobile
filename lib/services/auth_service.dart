import 'package:http/http.dart' as http;
import 'package:notes_on_map/constants.dart';

class AuthService {
  static Future<http.Response> logout(String accessToken) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    //Make a post request with user info
    return await http.post('$kServerUrl/user/logout', headers: headers);
  }
}
