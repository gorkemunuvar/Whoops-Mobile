import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';

class MapSearchDelegate extends SearchDelegate<String> {
  final List<String> places = ['Aaaaa', 'bbbbbb', 'cccccc', 'dddddd', 'eeeee'];

  List<String> filterName = [];

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
    "Bethlehem",
    "Kadıköy",
    "Pozcu",
    "Turgut Özal"
  ];

  Widget _buildList() {
    final searchItems = query.isEmpty
        ? _history
        : _history
            .where((c) => c.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Container(
      color: kPrimaryWhiteColor,
      child: ListView.builder(
        itemCount: searchItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${searchItems[index]}'),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? _history
        : places.where((c) => c.toLowerCase().contains(query)).toList();

    return _buildList();

    /* return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            showResults(context);
            //close(context, suggestions[index]);
          },
        );
      },
    ); */
  }

  @override
  Widget buildResults(BuildContext context) {
    //Burası ise geriye arama sonuçlarını içeren bir screen döndürmeli.
    return _buildList();
  }
}
