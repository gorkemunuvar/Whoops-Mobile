import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notes_on_map/services/Testing.dart';
import 'package:notes_on_map/services/Networking.dart';
import 'package:notes_on_map/components/rounded_button.dart';
import 'package:notes_on_map/components/rounded_input_field.dart';

class BottomSheetModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Testing test = Testing();
    Networking networking = Networking();
    String url = 'https://fef9ad34cafb.ngrok.io';

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
              press: () {
                if (whoop != '' && time != '') {
                  networking.post(
                      '$url/sharenote',
                      jsonEncode({
                        'nick': 'gorkem',
                        'latitude': '38.73222',
                        'longitude': '35.48528',
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
