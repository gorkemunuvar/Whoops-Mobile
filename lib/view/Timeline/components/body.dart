import '../../utils/whoop_card.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:notes_on_map/providers/whoops_provider.dart';

import 'package:notes_on_map/models/whoop_model.dart';
import 'package:notes_on_map/helpers/location_name_helper.dart';

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
      //Consumer yeni veri geldiğinde ListView'ı tekrar çizmiyor. Bu şuan için problem değil.
      //Çünkü Timeline'da bir anda çok fazla whoop gelirse kullanıcı deneyimi için kötü olabilir.
      //Ama problem başka yerlerde kullanmak üzere çözülse iyi olur.
      child: Consumer<WhoopsProvider>(
        builder: (context, data, child) {
          print('CONSUMER WOKRED...................');

          String location;
          List<Whoop> whoops = data.whoops;
          whoops = whoops.reversed.toList();

          return ListView.builder(
            itemCount: whoops.length,
            itemBuilder: (BuildContext context, int i) {
              location = LocationNameHelper.getLocation(whoops[i].address);

              return WhoopCard(
                title: whoops[i].title,
                date: whoops[i].dateCreated,
                location: location,
                tags: List<String>.from(whoops[i].tags),
                time: whoops[i].time.toString(),
                haveProfilePicture: true,
              );
            },
          );
        },
      ),
    );
  }
}
