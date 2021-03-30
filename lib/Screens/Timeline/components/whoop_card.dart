import 'package:flutter/material.dart';
import 'package:notes_on_map/components/circle_avatar_component.dart';

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
