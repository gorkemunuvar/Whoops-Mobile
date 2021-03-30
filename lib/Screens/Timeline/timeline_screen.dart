import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'components/whoop_search_delegate.dart';
import 'package:notes_on_map/screens/Timeline/components/body.dart';
import 'package:notes_on_map/components/circle_avatar_component.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  //Places yerine bir whoop'a ait tüm veriler belirli bir sayıda
  //çekilir ve timeline anasayfasında listelenebilir.
  final List<String> places = [
    "Kadıköy",
    "Beşiktaş",
    "Talas",
    "Karaköy",
    "Pozcu",
    "Turgut Özal",
    "Kadıköy",
  ];

  String query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akış'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String selected = await showSearch(
                context: context,
                delegate: WhoopSearchDelegate(places),
              );

              if (selected != null && selected != query) {
                setState(() {
                  query = selected;
                });
              }
            },
          )
        ],
      ),
      body: Body(),
    );
  }
}
