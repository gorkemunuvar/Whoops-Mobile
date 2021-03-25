import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_on_map/components/text_field_component.dart';
import 'package:notes_on_map/Screens/SignIn/components/background.dart';
import 'package:notes_on_map/components/button_component.dart';

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
                      CheckBoxWidget(),
                      Text(
                        'Remember Me',
                        style: TextStyle(
                          color: kPrimaryDarkColor,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: kPrimaryDarkColor,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50.0,
                child: ButtonComponent(
                  text: 'Sign In',
                  textColor: kPrimaryWhiteColor,
                  backgroundColor: kPrimaryDarkColor,
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 50.0,
                child: ButtonComponent(
                  text: 'Sign Up',
                  textColor: kPrimaryDarkColor,
                  backgroundColor: kPrimaryWhiteColor,
                ),
              ),
              SizedBox(height: 75),
              Center(
                child: Text(
                  'Or Login With',
                  style:
                      TextStyle(color: kPrimaryDarkColor, fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(height: 15),
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

class CheckBoxWidget extends StatefulWidget {
  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
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
