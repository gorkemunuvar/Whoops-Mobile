import 'package:flutter/material.dart';
import 'package:notes_on_map/Screens/Login/login_screen.dart';
import 'package:notes_on_map/Screens/Signup/signup_screen.dart';
import 'package:notes_on_map/Screens/Welcome/components/background.dart';
import 'package:notes_on_map/components/rounded_button.dart';
import 'package:notes_on_map/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to Whoops!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: size.height * 0.15),
            Image.asset(
              "assets/icons/welcome.png",
              height: 200,
              width: 200,
              fit: BoxFit.fitWidth,
            ),
            /* SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ), */
            SizedBox(height: size.height * 0.15),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
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
