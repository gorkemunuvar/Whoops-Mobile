import 'package:flutter/material.dart';
import 'package:notes_on_map/components/button_component.dart';
import 'package:notes_on_map/components/circle_avatar_component.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/screens/Timeline/components/background.dart';
import 'package:notes_on_map/screens/Timeline/components/body.dart';

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
                delegate: WhoopSearchDele(places),
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
      body: Container(
        child: _buildList(''),
      ),

      //resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildList(_searchText) {
    final searchItems = query.isEmpty
        ? places
        : places
            .where((c) => c.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: searchItems.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
          child: WhoopCard(searchItems: searchItems, title: searchItems[index]),
        );
        /* return ListTile(
          title: Text((searchItems[index])),
          leading: Icon(Icons.location_city),
          subtitle: Text('Search'),
        ); */
      },
    );
  }
}

class WhoopSearchDele extends SearchDelegate<String> {
  final List<String> places;

  List<String> filterName = [];

  WhoopSearchDele(this.places);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon((Icons.clear)),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Burası ise geriye arama sonuçlarını içeren bir screen döndürmeli.
    return Container(
      color: Colors.red,
    );
  }

  final List<String> _history = [
    "Aurora",
    "Austin",
    "Bakersfield",
    "Baltimore",
    "Barnstable",
    "Baton Rouge",
    "Beaumont",
    "Bel Air",
    "Bellevue",
    "Berkeley",
    "Bethlehem"
  ];

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? _history
        : places.where((c) => c.toLowerCase().contains(query)).toList();

    //Bu kısım streambuilder olmalı.
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
            title: Text(suggestions[index]),
            onTap: () {
              showResults(context);
              //close(context, suggestions[index]);
            },
          );
        });
  }
}

class WhoopCard extends StatelessWidget {
  final List<String> searchItems;
  final String title;

  WhoopCard({@required this.searchItems, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              //Picture column
              child: Column(
                children: [
                  CircleAvatarComponent(radius: 38),
                  SizedBox(height: 7),
                  Text(
                    'Aslı Gamze',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            //Info Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Sokak müziğimize katıl!',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text('Aktif',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(title),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.date_range),
                    Text('19 Nisan'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.timer),
                    Text('13:55 - 16:00'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.tag),
                    Text('#Müzik #Gitar'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
