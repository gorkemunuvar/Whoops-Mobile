import 'whoop_card.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final List<String> places = [
    "Kadıköy",
    "Beşiktaş",
    "Talas",
    "Karaköy",
    "Pozcu",
    "Turgut Özal",
    "Kadıköy",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(child: _buildList());
  }

  String query = '';
  Widget _buildList() {
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
      },
    );
  }
}
