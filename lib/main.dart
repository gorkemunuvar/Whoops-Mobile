import 'constants.dart';
import 'package:flutter/material.dart';
import 'screens/Signup/signup_screen.dart';
import 'screens/Signin/signin_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes-On-Map',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SignInScreen(),
    );
  }
}
