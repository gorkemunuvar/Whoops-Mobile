import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:whoops/controller/user_service.dart';
import 'package:whoops/view/utils/button_component.dart';
import 'package:whoops/view/utils/text_field_component.dart';
import 'package:whoops/view/utils/circle_avatar_component.dart';
import 'package:whoops/view/ChangePassword/components/background.dart';
import 'package:whoops/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:whoops/model/user_model.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: SingleChildScrollView(
          child: Consumer<UserProvider>(
            builder: (context, data, child) {
              User user = data.user;

              TextEditingController aboutMeTextEditingController =
                  TextEditingController(text: user.aboutMe);
              TextEditingController firstNameTextEditingController =
                  TextEditingController(text: user.firstName);
              TextEditingController lastNameTextEditingController =
                  TextEditingController(text: user.lastName);
              TextEditingController phoneTextEditingController =
                  TextEditingController(text: user.phoneNumber);
              TextEditingController twitterTextEditingController =
                  TextEditingController(text: user.twitterUsername);
              TextEditingController instagramTextEditingController =
                  TextEditingController(text: user.instagramUsername);
              TextEditingController facebookTextEditingController =
                  TextEditingController(text: user.facebookUsername);

              return Column(
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
                  TextFieldComponent(
                    hintText: 'Hakkımda',
                    controller: aboutMeTextEditingController,
                  ),
                  TextFieldComponent(
                    hintText: 'Ad',
                    controller: firstNameTextEditingController,
                  ),
                  TextFieldComponent(
                      hintText: 'Soyad',
                      controller: lastNameTextEditingController),
                  TextFieldComponent(
                    hintText: 'Telefon',
                    controller: phoneTextEditingController,
                  ),
                  TextFieldComponent(
                    hintText: 'Twitter Kullanıcı Adı',
                    controller: twitterTextEditingController,
                  ),
                  TextFieldComponent(
                      hintText: 'Instagram Kullanıcı Adı',
                      controller: instagramTextEditingController),
                  TextFieldComponent(
                      hintText: 'Facebook Kullanıcı Adı',
                      controller: facebookTextEditingController),
                  SizedBox(height: 15),
                  ButtonComponent(
                    text: 'Değişiklikleri Kaydet',
                    textColor: kPrimaryWhiteColor,
                    backgroundColor: kPrimaryDarkColor,
                    onPressed: () {
                      dynamic updatedUser = {
                        'about_me': aboutMeTextEditingController.text,
                        'first_name': firstNameTextEditingController.text,
                        'last_name': lastNameTextEditingController.text,
                        'phone_number': phoneTextEditingController.text,
                        'twitter_username': twitterTextEditingController.text,
                        'instagram_username':
                            instagramTextEditingController.text,
                        'facebook_username': facebookTextEditingController.text
                      };

                      UserService.updateAccount(
                        jsonEncode(updatedUser),
                        data.accessToken,
                      );

                      Navigator.pushNamed(context, '/map');
                    },
                  ),
                  SizedBox(height: 15),
                  ButtonComponent(
                    text: 'Şifreni Değiştir',
                    textColor: kPrimaryWhiteColor,
                    backgroundColor: kPrimaryDarkColor,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/changePassword'),
                  ),
                  SizedBox(height: 7),
                  ButtonComponent(
                    text: 'Kullanıcı Adını Değiştir',
                    textColor: kPrimaryWhiteColor,
                    backgroundColor: kPrimaryDarkColor,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/changeUsername'),
                  ),
                  SizedBox(height: 7),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
