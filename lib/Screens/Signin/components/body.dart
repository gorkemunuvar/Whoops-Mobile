import 'background.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_on_map/components/button_component.dart';
import 'package:notes_on_map/components/text_field_component.dart';

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
              SizedBox(
                height: size.height / 3,
              ),
              SvgPicture.asset('assets/images/logo.svg'),
              TextFieldComponent(hintText: 'Kullanıcı adı'),
              TextFieldComponent(hintText: 'Şifre', obscureText: true),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _CheckBoxWidget(),
                      Text(
                        'Beni Hatırla',
                        style: TextStyle(
                          color: kPrimaryDarkColor,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Text(
                      'Şifremi Unuttum',
                      style: TextStyle(
                        color: kPrimaryDarkColor,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    onTap: () =>
                        Navigator.pushNamed(context, '/forgotPassword'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ButtonComponent(
                text: 'Giriş',
                textColor: kPrimaryWhiteColor,
                backgroundColor: kPrimaryDarkColor,
                onPressed: () {
                  Navigator.pushNamed(context, '/map');
                },
              ),
              SizedBox(height: 10),
              ButtonComponent(
                text: 'Yeni Hesap',
                textColor: kPrimaryDarkColor,
                backgroundColor: kPrimaryWhiteColor,
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');
                },
              ),
              SizedBox(height: 75),
              Center(
                child: Text(
                  'ile giriş yap',
                  style:
                      TextStyle(color: kPrimaryDarkColor, fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    AssetImage("assets/icons/google.png"),
                    size: 50.0,
                  ),
                  SizedBox(width: 7),
                  ImageIcon(
                    AssetImage("assets/icons/facebook.png"),
                    size: 42.0,
                  ),
                  SizedBox(width: 7),
                  ImageIcon(
                    AssetImage("assets/icons/twitter.png"),
                    size: 52.0,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckBoxWidget extends StatefulWidget {
  @override
  __CheckBoxWidgetState createState() => __CheckBoxWidgetState();
}

class __CheckBoxWidgetState extends State<_CheckBoxWidget> {
  bool rememberMe = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.0,
      width: 24.0,
      child: Checkbox(
        checkColor: kPrimaryWhiteColor,
        activeColor: kPrimaryDarkColor,
        value: rememberMe,
        onChanged: _onRememberMeChanged,
      ),
    );
  }
}
