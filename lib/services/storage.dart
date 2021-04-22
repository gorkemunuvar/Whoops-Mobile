import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<Map<String, String>> readTokens() async {
    final prefs = await SharedPreferences.getInstance();

    // If the exp1 is not-null, returns its value, otherwise returns 0.
    final accessToken = prefs.getString('whoops_access_token') ?? '0';
    final refreshToken = prefs.getString('whoops_refresh_toekn') ?? '0';

    String status = 'has_token';
    if (accessToken != '0' && refreshToken != '0') status = 'has_not_token';

    Map<String, String> tokens = {
      'status': status.toString(),
      'whoops_access_token': accessToken,
      'whoops_refresh_token': refreshToken,
    };

    return tokens;
  }

  Future<bool> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();

    bool state1 = await prefs.setString('whoops_access_token', accessToken);
    bool state2 = await prefs.setString('whoops_refresh_token', refreshToken);

    if (state1 && state2) return true;
    return false;
  }

  Future<bool> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();

    bool status = await prefs.setString('whoops_access_token', accessToken);

    return status;
  }
}
