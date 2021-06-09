import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/view/utils/whoop_card.dart';
import 'package:whoops/view/utils/circle_avatar_component.dart';
import 'package:whoops/view/utils/flutter_map_component.dart';

import 'package:provider/provider.dart';
import 'package:whoops/controller/user_service.dart';
import 'package:whoops/provider/auth_token_provider.dart';

import 'package:whoops/model/user_model.dart';
import 'package:whoops/model/whoop_model.dart';

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
    return Consumer<AuthTokenProvider>(
      builder: (context, tokenData, child) {
        return FutureBuilder(
          future: UserService.getMyProfileUser(tokenData.accessToken),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: kPrimaryWhiteColor,
                    pinned: _pinned,
                    snap: _snap,
                    floating: _floating,
                    expandedHeight: 350.0,
                    flexibleSpace: _buildFlexibleSpaceBar(
                      snapshot.data.whoops.length,
                    ),
                  ),
                  _buildSliverList(snapshot.data.whoops),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  //Flexible component for CustomScrollView
  Widget _buildFlexibleSpaceBar(int whoopsCount) {
    return FlexibleSpaceBar(
      background: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Map Stack
          _ProfileMapComponent(),
          SizedBox(height: 10),
          //Info column
          _ProfileInfoComponent(whoopsCount: whoopsCount),
        ],
      ),
    );
  }

  //List of Whoop Cards
  Widget _buildSliverList(List<Whoop> whoops) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            color: kPrimaryWhiteColor,
            child: Center(
              child: WhoopCard(
                title: whoops[index].title,
                location: whoops[index].latitude.toString().substring(0, 5) +
                    ' - ' +
                    whoops[index].longitude.toString().substring(0, 6),
                date: '23 Mayıs',
                time: whoops[index].time.toString(),
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
  final int whoopsCount;

  _ProfileInfoComponent({this.whoopsCount});

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
            Text('Kayseri, TR', style: TextStyle(color: kPrimaryDarkColor)),
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
        SizedBox(height: 25),
        Text(
          whoopsCount != 0
              ? 'Whoop\'larım'
              : 'Şimdiye kadar hiç whoop\'lamadınız!',
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
            child: FlutterMapComponent(),
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
                  '@asligamze',
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
