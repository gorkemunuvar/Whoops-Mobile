import 'dart:math';
import 'dart:convert';

class Testing {
  String createRandomJson() {
    Random random = Random();

    final json = jsonEncode({
      'nick': 'test',
      'latitude': '${random.nextInt(90)}.1578',
      'longitude': '${random.nextInt(90)}.7896',
      'note': 'What up?',
      'time': '${random.nextInt(30)}',
    });

    return json;
  }
}
