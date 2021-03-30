import 'constants.dart';
import 'package:flutter/material.dart';
import 'screens/Signin/signin_screen.dart';
import 'screens/Signup/signup_screen.dart';
import 'screens/Settings/settings_screen.dart';
import 'screens/ChangeEmail/change_email.dart';
import 'screens/ForgotPassword/forgot_password.dart';
import 'screens/ChangePassword/change_password.dart';
import 'screens/Timeline/timeline_screen.dart';
import 'screens/OtherUsers/other_users_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whoops',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: OtherUsersScreen(),
    );
  }
}
