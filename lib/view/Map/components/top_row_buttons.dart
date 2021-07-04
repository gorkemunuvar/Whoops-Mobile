import 'map_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';

//Top buttons on the map screen
class TopRowButtons extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key;
  TopRowButtons(this._key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _iconButton(
          Icons.menu,
          onPressed: () {
            _key.currentState.openDrawer();
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _iconButton(
              Icons.search_rounded,
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: MapSearchDelegate(),
                );
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _iconButton(IconData icon, {Function onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.7),
        border: Border.all(style: BorderStyle.none),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: 32.0,
          color: kPrimaryDarkColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
