import 'package:http/http.dart' as http;

class Networking {
  void post(String url, String json) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    http.Response response = await http.post(
      url,
      headers: headers,
      body: json,
    );

    print('Response status: ${response.statusCode}');
  }
}
