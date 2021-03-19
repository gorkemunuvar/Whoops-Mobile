import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/services/CurrentLocation.dart';
import 'package:notes_on_map/services/Testing.dart';
import 'package:notes_on_map/services/Networking.dart';
import 'package:notes_on_map/components/rounded_button.dart';
import 'package:notes_on_map/components/rounded_input_field.dart';

class BottomSheetModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Testing test = Testing();
    Networking networking = Networking();
    String url = 'https://3940dcd92377.ngrok.io';

    String whoop, time;
    return Container(
      height: 240,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RoundedInputField(
              hintText: "Whoop what you do!",
              icon: Icons.record_voice_over,
              onChanged: (value) => whoop = value,
            ),
            RoundedInputField(
              hintText: "Time for whoop (second)",
              icon: Icons.timer,
              onChanged: (value) => time = value,
            ),
            RoundedButton(
              text: 'Share',
              press: () async {
                CurrentLocation cLocation = CurrentLocation();
                LatLng currentLocation = await cLocation.get();
                print('Location: $currentLocation');

                if (whoop != '' && time != '') {
                  networking.post(
                      '$url/sharenote',
                      jsonEncode({
                        'nick': 'gorkem',
                        'latitude': currentLocation.latitude.toString(),
                        'longitude': currentLocation.longitude.toString(),
                        'note': whoop,
                        'time': time,
                      }));
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
