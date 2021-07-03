import 'circle_avatar_component.dart';
import 'package:flutter/material.dart';

class WhoopCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String time;
  final List<String> tags;
  final bool haveProfilePicture;

  WhoopCard({
    this.title,
    this.location,
    this.date,
    this.time,
    this.tags,
    this.haveProfilePicture = false,
  });

  @override
  Widget build(BuildContext context) {
    int maxStringLength = haveProfilePicture ? 28 : 35;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            haveProfilePicture
                ? Padding(
                    padding: EdgeInsets.all(8.0),
                    //Picture column
                    child: Column(
                      children: [
                        GestureDetector(
                          child: CircleAvatarComponent(
                            radius: 38,
                            borderSize: 1,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/anotherUser');
                          },
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Aslı Gamze',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(width: 10.0),
            //Info Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title.length > maxStringLength
                          ? '${title.substring(0, maxStringLength)}...'
                          : title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(location),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.date_range),
                    Text(date),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.timer),
                    Text(time),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.tag),
                    Text('#${tags.join('#')}'),
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
