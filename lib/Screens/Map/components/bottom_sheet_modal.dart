import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/components/rounded_button.dart';
import 'package:notes_on_map/components/rounded_input_field.dart';

class BottomSheetModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryWhiteColor,
      height: 240,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RoundedInputField(
              hintText: "Whoop what you do!",
              icon: Icons.record_voice_over,
              onChanged: (value) => value,
            ),
            RoundedInputField(
              hintText: "Time for whoop (second)",
              icon: Icons.timer,
              onChanged: (value) => value,
            ),
            RoundedButton(
              text: 'Share',
              press: () async {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
