import '../../../components/whoop_card.dart';
import 'package:flutter/material.dart';

String query = '';

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
    return Container(
      child: _buildList(),
    );
  }

  Widget _buildList() {
    final searchItems = query.isEmpty
        ? places
        : places
            .where((c) => c.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Container(
      child: ListView.builder(
        itemCount: searchItems.length,
        itemBuilder: (BuildContext context, int index) {
          return WhoopCard(
            title: searchItems[index],
          );
        },
      ),
    );
  }
}
