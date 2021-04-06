import 'package:flutter/material.dart';
import 'package:notes_on_map/components/circle_avatar_component.dart';

class MesssageInfoCard extends StatelessWidget {
  final List<String> searchItems;
  final String title;

  MesssageInfoCard({@required this.searchItems, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: CircleAvatarComponent(radius: 30),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('5 dk içinde orada olacağım :)'),
      ),
      onTap: () => Navigator.pushNamed(context, '/messageDetails'),
    );
  }
}
