import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whoops/controller/auth_service.dart';
import 'package:whoops/model/user_model.dart';
import 'package:whoops/provider/user_provider.dart';
import 'package:whoops/view/Map/components/body.dart';

import 'package:http/http.dart' as http;

class MapScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: globalKey,
        drawer: Drawer(
          child: Container(
            width: 50,
            color: Colors.white,
            child: Stack(
              children: [
                ListView(
                  children: [
                    Consumer<UserProvider>(
                      builder: (context, data, child) {
                        User user = data.user;

                        print(jsonEncode(user.toJson()));

                        return GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/profile.png'),
                                  radius: 40,
                                ),
                                SizedBox(width: 18),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // "afadssssssssssssffffffffflastName}",
                                        "${user.firstName} ${user.lastName}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text("@${user.username}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () =>
                              Navigator.pushNamed(context, '/myProfile'),
                        );
                      },
                    ),
                    Divider(thickness: 1),
                    _listTile(
                      "Mesajlar",
                      Icons.message,
                      () => Navigator.pushNamed(context, '/messages'),
                    ),
                    _listTile(
                      "Ayarlar",
                      Icons.settings,
                      () => Navigator.pushNamed(context, '/settings'),
                    ),
                  ],
                ),
                Consumer<UserProvider>(
                  builder: (context, tokenData, child) {
                    return Align(
                      alignment: Alignment.bottomLeft,
                      child: _listTile(
                        "Çıkış Yap",
                        Icons.exit_to_app,
                        () async {
                          print(tokenData.accessToken);
                          await _handleLogout(context, tokenData.accessToken);
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        body: Body(globalKey),
      ),
    );
  }

  ListTile _listTile(String title, IconData leading, Function onTap) {
    return ListTile(
      title: Text(title),
      leading: Icon(leading),
      onTap: onTap,
    );
  }

  Future<void> _handleLogout(BuildContext context, String accessToken) async {
    http.Response response = await AuthService.logout(accessToken);

    if (response.statusCode == 200) {
      print('User logged out.');

      Navigator.pushReplacementNamed(context, '/signIn');
    } else {
      print('Something went wrong! (My Profile Screen)');
      print('Status Code: ${response.statusCode}');
    }
  }
}
