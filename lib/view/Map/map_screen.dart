import 'package:flutter/material.dart';
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
            color: Colors.white,
            child: ListView(
              children: [
                _listTile(
                  "Profilim",
                  Icons.person,
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
