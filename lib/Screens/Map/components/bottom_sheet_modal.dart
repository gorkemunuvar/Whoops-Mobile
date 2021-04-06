import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/components/rounded_button.dart';
import 'package:notes_on_map/components/button_component.dart';
import 'package:notes_on_map/components/rounded_input_field.dart';
import 'package:notes_on_map/components/text_field_component.dart';
import 'package:flutter/cupertino.dart';

class BottomSheetModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        //color: kPrimaryWhiteColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 5.0),
                child: TextFieldComponent(
                  hintText: 'Ne yaptığını hemen whoopla!',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 5.0),
                child: TextFieldComponent(hintText: '#Etiketler'),
              ),
              //It can be a CupertinePicker instead.
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 5.0),
                child: TextFieldComponent(hintText: 'Whoop süresi(sn)'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                child: ButtonComponent(
                  text: 'Share',
                  textColor: kPrimaryWhiteColor,
                  backgroundColor: kPrimaryDarkColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
