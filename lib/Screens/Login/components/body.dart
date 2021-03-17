import 'package:flutter/material.dart';
import 'package:notes_on_map/Screens/Login/components/background.dart';
import 'package:notes_on_map/Screens/Signup/signup_screen.dart';
import 'package:notes_on_map/components/already_have_an_account_acheck.dart';
import 'package:notes_on_map/components/rounded_button.dart';
import 'package:notes_on_map/components/rounded_input_field.dart';
import 'package:notes_on_map/components/rounded_password_field.dart';
import 'package:notes_on_map/Screens/Map/map_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/icons/login.png",
              height: size.height * 0.35,
              fit: BoxFit.fill,
            ),

            /* SvgPicture.asset(
              "assets/icons/login.png",
              height: size.height * 0.35,
            ), */
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MapScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
