import 'components/body.dart';
import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';

import 'package:provider/provider.dart';
import 'package:whoops/provider/user_provider.dart';

import 'package:http/http.dart' as http;
import 'package:whoops/controller/auth_service.dart';

class MyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhiteColor,
      appBar: _buildAppBar(context),
      body: Body(),
    );
  }

  //Expire süresi 15. dk. Login olunca 15 dk geçtikten sonra logout olunmaya çalışılırsa
  //hata veriyor olabilir. Çünkü /logout endpointinde @jwt_required() decorator çalıştığı için
  //auth. işlemi expire olmuş access token kabul etmiyor.
  //Çözüm: Logout olmadan önce refresh token ile yeni bir access token üretmek.
  Future<void> _handleLogout(BuildContext context, String accessToken) async {
    http.Response response = await AuthService.logout(accessToken);

    if (response.statusCode == 200) {
      print('User logged out.');

      Navigator.pushNamed(context, '/signIn');
    } else {
      print('Something went wrong! (My Profile Screen)');
      print('Status Code: ${response.statusCode}');
    }
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryDarkColor,
      title: Text(
        'Profilim',
        style: TextStyle(color: kPrimaryWhiteColor),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        Consumer<UserProvider>(
          builder: (context, tokenData, child) {
            return IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                print(tokenData.accessToken);
                await _handleLogout(context, tokenData.accessToken);
              },
            );
          },
        )
      ],
    );
  }
}
