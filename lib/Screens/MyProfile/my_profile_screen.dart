import 'components/body.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';

import 'package:provider/provider.dart';
import 'package:notes_on_map/providers/auth_token_provider.dart';

import 'package:http/http.dart' as http;

class MyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhiteColor,
      appBar: _buildAppBar(context),
      body: Body(),
    );
  }

  Future<void> _handleLogout(BuildContext context, String accessToken) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    //Make a post request with user info
    http.Response response = await http.post(
      '$kServerUrl/logout',
      headers: headers,
    );

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
        Consumer<AuthTokenProvider>(
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
