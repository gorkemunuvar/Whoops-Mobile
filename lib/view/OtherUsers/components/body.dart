import 'package:flutter/material.dart';
import 'package:whoops/view/OtherUsers/components/user_info_card.dart';

String query = '';

class Body extends StatelessWidget {
  final List<String> users = [
    "Görkem",
    "Ahmet",
    "Ezgi",
    "Erdem",
    "Burcu",
    "Mamfi",
    "Yahya",
    "Fatma",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildList(),
    );
  }

  Widget _buildList() {
    final searchItems = query.isEmpty
        ? users
        : users
            .where((c) => c.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Container(
      child: ListView.builder(
        itemCount: searchItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 3.0,
              horizontal: 10.0,
            ),
            child: UserInfoCard(
              searchItems: searchItems,
              title: searchItems[index],
            ),
          );
        },
      ),
    );
  }
}
