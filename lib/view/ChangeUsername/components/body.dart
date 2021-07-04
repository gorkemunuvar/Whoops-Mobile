import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/view/utils/button_component.dart';
import 'package:whoops/view/utils/text_field_component.dart';
import 'package:whoops/view/ChangeUsername/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15),
              TextFieldComponent(hintText: 'Şifre', obscureText: true),
              TextFieldComponent(hintText: 'Yeni e-posta adresi'),
              SizedBox(height: 15),
              ButtonComponent(
                text: 'Güncelle',
                textColor: kPrimaryWhiteColor,
                backgroundColor: kPrimaryDarkColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
