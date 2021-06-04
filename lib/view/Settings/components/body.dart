import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/view/utils/button_component.dart';
import 'package:whoops/view/utils/text_field_component.dart';
import 'package:whoops/view/utils/circle_avatar_component.dart';
import 'package:whoops/view/ChangePassword/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15),
              CircleAvatarComponent(
                radius: 50,
                borderSize: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      'Değiştir',
                      style: TextStyle(
                        color: kPrimaryDarkColor,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              TextFieldComponent(hintText: 'Hakkımda'),
              TextFieldComponent(hintText: 'Kullanıcı Adı'),
              TextFieldComponent(hintText: 'Ad'),
              TextFieldComponent(hintText: 'Soyad'),
              TextFieldComponent(hintText: 'Telefon Numarası'),
              TextFieldComponent(hintText: 'Twitter Linki'),
              TextFieldComponent(hintText: 'Instagram Linki'),
              TextFieldComponent(hintText: 'Facebook Linki'),
              SizedBox(height: 15),
              ButtonComponent(
                text: 'Şifre Değiştir',
                textColor: kPrimaryWhiteColor,
                backgroundColor: kPrimaryDarkColor,
                onPressed: () =>
                    Navigator.pushNamed(context, '/changePassword'),
              ),
              SizedBox(height: 7),
              ButtonComponent(
                text: 'Eposta Değiştir',
                textColor: kPrimaryWhiteColor,
                backgroundColor: kPrimaryDarkColor,
                onPressed: () => Navigator.pushNamed(context, '/changeEmail'),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
