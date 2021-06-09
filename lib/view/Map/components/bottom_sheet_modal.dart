import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:whoops/model/whoop_model.dart';
import 'package:whoops/controller/whoop_service.dart';
import 'package:whoops/view/utils/button_component.dart';
import 'package:whoops/provider/auth_token_provider.dart';
import 'package:whoops/view/utils/text_field_component.dart';

int _whoopTime;
String _tags;
String _whoopTitle;

Random random = Random();

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
              child: Consumer<AuthTokenProvider>(
                  builder: (context, tokenData, child) {
                return ButtonComponent(
                  text: 'Paylaş',
                  textColor: kPrimaryWhiteColor,
                  backgroundColor: kPrimaryDarkColor,
                  onPressed: () {
                    double rndLatitude = random.nextDouble() * 100 / 2;
                    double rndLongitude = random.nextDouble() * 100 / 2;

                    if (rndLatitude > 90.0) rndLatitude = 45.0;
                    if (rndLongitude > 90.0) rndLongitude = 45.0;

                    Whoop whoop = Whoop(
                      _whoopTitle,
                      rndLatitude,
                      rndLongitude,
                      _whoopTime,
                    );

                    String accessToken = tokenData.accessToken;
                    WhoopService.share(whoop, accessToken);

                    Navigator.pop(context);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
