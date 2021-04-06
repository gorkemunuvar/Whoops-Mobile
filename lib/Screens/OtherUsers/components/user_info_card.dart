import 'package:flutter/material.dart';
import 'package:notes_on_map/components/circle_avatar_component.dart';

class UserInfoCard extends StatelessWidget {
  final List<String> searchItems;
  final String title;

  UserInfoCard({@required this.searchItems, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: CircleAvatarComponent(radius: 30),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('@asligamze_\nİstanbul, TR'),
        trailing: IconButton(
          icon: Icon(Icons.message),
          onPressed: () {
            Navigator.pushNamed(context, '/messageDetails');
          },
        ),
        isThreeLine: true,
        onTap: () => Navigator.pushNamed(context, '/anotherUser'),
      ),
    );
  }
}
