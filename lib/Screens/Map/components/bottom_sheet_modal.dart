import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/components/button_component.dart';
import 'package:notes_on_map/components/text_field_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_on_map/services/whoop_service.dart';
import 'package:notes_on_map/modals/whoop_modal.dart';

int _whoopTime;
String _whoopTitle;
String _tags;

class BottomSheetModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
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
                onChanged: (value) => _whoopTitle = value,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 5.0),
              child: TextFieldComponent(
                hintText: '#Etiketler',
                onChanged: (value) => _tags = value,
              ),
            ),
            //It can be a CupertinePicker instead.
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 5.0),
              child: TextFieldComponent(
                hintText: 'Whoop süresi(sn)',
                onChanged: (value) => _whoopTime = int.parse(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: ButtonComponent(
                text: 'Paylaş',
                textColor: kPrimaryWhiteColor,
                backgroundColor: kPrimaryDarkColor,
                onPressed: () {
                  Whoop whoop = Whoop(
                    _whoopTitle,
                    35.7589,
                    45.6982,
                    _whoopTime,
                  );

                  WhoopService.share(whoop);

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
