import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_on_map/services/whoop_service.dart';
import 'package:notes_on_map/models/whoop_model.dart';
import 'package:notes_on_map/models/address_model.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:whoops/model/whoop_model.dart';
import 'package:whoops/controller/whoop_service.dart';
import 'package:whoops/view/utils/button_component.dart';
import 'package:whoops/provider/auth_token_provider.dart';
import 'package:whoops/view/utils/text_field_component.dart';

import 'package:notes_on_map/services/reverse_geocoding_service.dart';

int _whoopTime;
String _whoopTitle;
String _tagsInput;

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
                onChanged: (value) => _tagsInput = value,
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
                  onPressed: () async {
                    double rndLatitude =
                        random.nextInt(5) + 37 + random.nextDouble();
                    double rndLongitude =
                        random.nextInt(15) + 28 + random.nextDouble();

                    //Without subString(1) it adds a space at the beginning of the arr.
                    List<String> tags =
                        _tagsInput.trim().substring(1).split('#');

                    //Trim all the elements in tags arr.
                    for (int i = 0; i < tags.length; i++) {
                      tags[i] = tags[i].trim();
                    }

                    http.Response response = await ReverseGeocoding.getAdress(
                      rndLatitude,
                      rndLongitude,
                    );

                    dynamic addressMap = jsonDecode(response.body);
                    Address address = Address.fromJson(addressMap['address']);

                    Whoop whoop = Whoop(_whoopTitle, rndLatitude, rndLongitude,
                        _whoopTime, tags, address);

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
