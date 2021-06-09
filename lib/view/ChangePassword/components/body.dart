import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/view/utils/button_component.dart';
import 'package:whoops/view/utils/text_field_component.dart';
import 'package:whoops/view/ChangePassword/components/background.dart';

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
              TextFieldComponent(hintText: 'Mevcut şifre', obscureText: true),
              TextFieldComponent(hintText: 'Yeni şifre', obscureText: true),
              TextFieldComponent(
                  hintText: 'Yeni şifre tekrar', obscureText: true),
              SizedBox(height: 15),
              ButtonComponent(
                text: 'Şifremi Değiştir',
                textColor: kPrimaryWhiteColor,
                backgroundColor: kPrimaryDarkColor,
                onPressed: () {},
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Text(
                  'Şifremi Unuttum',
                  style: TextStyle(
                    color: kPrimaryDarkColor,
                    fontFamily: 'Roboto',
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () => Navigator.pushNamed(context, '/forgotPassword'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
