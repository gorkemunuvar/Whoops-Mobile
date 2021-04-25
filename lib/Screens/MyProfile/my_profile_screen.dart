import 'components/body.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';

import 'package:provider/provider.dart';
import 'package:notes_on_map/providers/auth_token_provider.dart';

class MyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhiteColor,
      appBar: _buildAppBar(context),
      body: Body(),
    );
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
              onPressed: () {
                print(tokenData.accessToken);
                print(tokenData.refreshToken);
              },
            );
          },
        )
      ],
    );
  }
}
