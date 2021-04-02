import 'constants.dart';
import 'package:flutter/material.dart';
import 'screens/Map/map_screen.dart';
import 'screens/Signin/signin_screen.dart';
import 'screens/Signup/signup_screen.dart';
import 'screens/Settings/settings_screen.dart';
import 'screens/ChangeEmail/change_email.dart';
import 'screens/ForgotPassword/forgot_password.dart';
import 'screens/ChangePassword/change_password.dart';
import 'screens/Timeline/timeline_screen.dart';
import 'screens/OtherUsers/other_users_screen.dart';
import 'screens/AllMessages/all_messages_screen.dart';
import 'screens/MyProfile/my_profile_screen.dart';
import 'screens/AnotherUser/another_user_screen.dart';
import 'screens/MessageDetail/message_detail_screen.dart';

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
      home: MessageDetailScreen(),
    );
  }
}
