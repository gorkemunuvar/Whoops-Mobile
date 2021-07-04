import 'package:flutter/foundation.dart';
import 'package:whoops/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  String _accessToken = '';
  String _refreshToken = '';

  get user => _user;
  get accessToken => _accessToken;
  get refreshToken => _refreshToken;

  void updateUser(User user) {
    _user = user;
    notifyListeners();
  }

  void updateAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  void updateRefreshToken(String token) {
    _refreshToken = token;
    notifyListeners();
  }
}
