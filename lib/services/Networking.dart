import 'dart:convert';
import 'package:http/http.dart' as http;

class Networking {
  static Future<http.Response> post(String url, dynamic body) async {
    http.Response response = await http.post(
      url,
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );

    return response;
  }
}
