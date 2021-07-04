import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:provider/provider.dart';
import 'package:whoops/controller/user_service.dart';
import 'package:whoops/provider/user_provider.dart';

import 'package:whoops/model/user_model.dart';
import 'package:whoops/model/whoop_model.dart';
import 'package:whoops/model/address_model.dart';

import "package:latlong/latlong.dart" as latLng;
import 'package:whoops/helpers/location_name_helper.dart';
import 'whoop_card.dart';
import 'circle_avatar_component.dart';
import 'flutter_map_widget.dart';

import 'package:latlong/latlong.dart';

import 'package:whoops/provider/user_provider.dart';

class ProfileScreenBody extends StatefulWidget {
  @override
  _ProfileScreenBodyState createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, tokenData, child) {
        print(tokenData.accessToken);

        return FutureBuilder(
          future: UserService.getMyProfile(tokenData.accessToken),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                print(snapshot.data);

                User user = snapshot.data;

                Provider.of<UserProvider>(context, listen: false)
                    .updateUser(user);

                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: kPrimaryWhiteColor,
                      pinned: _pinned,
                      snap: _snap,
                      floating: _floating,
                      expandedHeight: 350.0,
                      flexibleSpace: _buildFlexibleSpaceBar(user),
                    ),
                    _buildSliverList(user.whoops),
                  ],
                );
              }
            }

            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  //Flexible component for CustomScrollView
  Widget _buildFlexibleSpaceBar(User user) {
    String lastLocation = '';
    List<Marker> markers = [];

    if (user.whoops.length != 0) {
      Address address = user.whoops[user.whoops.length - 1].address;
      lastLocation =
          '${address.province.length > 7 ? address.province.substring(0, 7) + '.' : address.province}, ${address.countryCode.toUpperCase()}';

      for (Whoop whoop in user.whoops) {
        double latitude = whoop.latitude;
        double longitude = whoop.longitude;

        Marker marker = Marker(
          anchorPos: AnchorPos.align(AnchorAlign.center),
          height: 40.0,
          width: 200.0,
          point: latLng.LatLng(latitude, longitude),
          builder: (context) => Icon(
            Icons.pin_drop,
            size: 30.0,
          ),
        );

        markers.add(marker);
      }
    }

    return FlexibleSpaceBar(
      background: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Map Stack
          _ProfileMapComponent(
            userName: user.username,
            markers: markers,
          ),
          SizedBox(height: 10),
          //Info column
          _ProfileInfoComponent(
            aboutMe: user.aboutMe,
            whoopsCount: user.whoops.length,
            lastLocation: lastLocation,
          ),
        ],
      ),
    );
  }

  //List of Whoop Cards
  Widget _buildSliverList(List<Whoop> whoops) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (whoops.length == 0)
            return Container(
              color: kPrimaryWhiteColor,
              child: Center(
                child: Text('Daha önce hiç whoop\'lamadınız :/'),
              ),
            );

          Address address = whoops[index].address;
          String location = LocationNameHelper.getLocation(address);

          return Container(
            color: kPrimaryWhiteColor,
            child: Center(
              child: WhoopCard(
                title: whoops[index].title,
                location: location,
                date: whoops[index].dateCreated,
                time: whoops[index].time.toString(),
                tags: List<String>.from(whoops[index].tags),
                haveProfilePicture: false,
              ),
            ),
          );
        },
        childCount: whoops.length,
      ),
    );
  }
}

//Texts and social media info icons
class _ProfileInfoComponent extends StatelessWidget {
  final String aboutMe;
  final int whoopsCount;
  final String lastLocation;

  _ProfileInfoComponent({this.aboutMe, this.whoopsCount, this.lastLocation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Row for texts
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '${whoopsCount.toString()} Whoops',
              style: TextStyle(color: kPrimaryDarkColor),
            ),
            SizedBox(),
            Text(lastLocation, style: TextStyle(color: kPrimaryDarkColor)),
          ],
        ),
        SizedBox(height: 15),
        //Row for icons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(),
            SizedBox(width: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Image.asset('assets/icons/twitter.png'),
                  iconSize: 30,
                  onPressed: () {},
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Image.asset('assets/icons/instagram.png'),
                  iconSize: 30,
                  onPressed: () {},
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Image.asset('assets/icons/facebook.png'),
                  iconSize: 26,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        aboutMe != null
            ? Text(
                aboutMe,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Text(''),
        SizedBox(height: 5),
        Text(
          whoopsCount != 0
              ? 'Whoop\'larım'
              : 'Şimdiye kadar hiç whoop\'lamadınız :/',
          style: TextStyle(
            color: kPrimaryDarkColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

//Map and Profile Picture
class _ProfileMapComponent extends StatelessWidget {
  final String userName;
  final List<Marker> markers;

  _ProfileMapComponent({this.userName, this.markers});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: [
          //Map
          SizedBox(
            height: 250,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(38.9573415, 35.240741),
                maxZoom: 18,
                zoom: 4.8,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: markers == null ? [] : markers,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Profile Picture
                CircleAvatarComponent(
                  radius: 40,
                  borderSize: 3,
                ),
                SizedBox(height: 5),
                Text(
                  '@$userName',
                  style: TextStyle(
                    color: kPrimaryDarkColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
