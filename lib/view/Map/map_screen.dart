import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whoops/model/user_model.dart';
import 'package:whoops/provider/user_provider.dart';
import 'package:whoops/view/Map/components/body.dart';

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

                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/profile.png'),
                                radius: 40,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: FittedBox(
                                  child: Text(
                                    "@${user.username}",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    _listTile(
                      "Profilim",
                      Icons.message,
                      () => Navigator.pushNamed(context, '/myProfile'),
                    ),
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
                Align(
                  alignment: Alignment.bottomLeft,
                  child: _listTile("Çıkış Yap", Icons.exit_to_app, () {}),
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
}
