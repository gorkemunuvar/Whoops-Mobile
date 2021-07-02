import 'package:flutter/foundation.dart';

class WhoopsProvider extends ChangeNotifier {
  String _accessToken = '';
  String _refreshToken = '';

  get accessToken => _accessToken;
  get refreshToken => _refreshToken;

  void updateAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  void updateRefreshToken(String token) {
    _refreshToken = token;
    notifyListeners();
  }
}
