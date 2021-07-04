import 'package:flutter_map/flutter_map.dart';
import 'package:whoops/controller/location_service.dart';

import 'bottom_sheet_modal.dart';
import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';

//Bottom buttons on the map screen
class BottomRowButtons extends StatelessWidget {
  final MapController _mapController;
  BottomRowButtons(this._mapController);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            heroTag: 'btn1',
            backgroundColor: kPrimaryDarkColor,
            child: Icon(
              Icons.gps_fixed,
              size: 30.0,
            ),
            onPressed: () {
              LocationService.getCurrentLocation().then(
                (_currentLocation) => _mapController.move(_currentLocation, 10),
              );
            },
          ),
        ),
        SizedBox(
          width: 65,
          height: 65,
          child: FloatingActionButton(
            heroTag: 'btn3',
            backgroundColor: kPrimaryDarkColor,
            child: Icon(
              Icons.add,
              size: 35.0,
            ),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return BottomSheetModal();
                },
              );
            },
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            heroTag: 'btn2',
            backgroundColor: kPrimaryDarkColor,
            child: Icon(
              Icons.timeline,
              size: 30.0,
            ),
            onPressed: () => Navigator.pushNamed(context, '/timeline'),
          ),
        ),
      ],
    );
  }
}
