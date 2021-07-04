import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/controller/whoop_service.dart';
import '../../utils/whoop_card.dart';
import 'package:provider/provider.dart';
import 'package:whoops/model/whoop_model.dart';
import 'package:whoops/helpers/location_name_helper.dart';
import 'package:whoops/provider/user_provider.dart';

class MapSearchDelegate extends SearchDelegate<String> {
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
        close(context, 'null');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: kPrimaryWhiteColor,
    );
  }

  Widget _buildList() {
    return Container(
      color: kPrimaryWhiteColor,
      child: Consumer<UserProvider>(
        builder: (context, user, child) {
          String location;

          Future<List<Whoop>> _futureFunc;

          if (query.startsWith('@'))
            _futureFunc = WhoopService.getActiveWhoopsByUsername(
              user.accessToken,
              query.substring(1, query.length),
            );
          else if (query.startsWith('#'))
            _futureFunc = WhoopService.getActiveWhoopsByTag(
              user.accessToken,
              query.substring(1, query.length),
            );
          else
            _futureFunc = WhoopService.getActiveWhoopsByTitle(
              user.accessToken,
              query,
            );
          ;

          return FutureBuilder<List<Whoop>>(
            future: _futureFunc,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Whoop> whoops = snapshot.data;

                if (whoops.length == 0)
                  return Container(
                    color: kPrimaryWhiteColor,
                    child: Center(
                      child: Text('Eşleşme bulunamadı.'),
                    ),
                  );
                whoops = whoops.reversed.toList();

                return ListView.builder(
                  itemCount: whoops.length,
                  itemBuilder: (BuildContext context, int i) {
                    location =
                        LocationNameHelper.getLocation(whoops[i].address);

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
              }

              return Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList();
  }
}
