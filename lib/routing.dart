import 'view/Map/map_screen.dart';
import 'package:flutter/material.dart';
import 'view/Signin/signin_screen.dart';
import 'view/Signup/signup_screen.dart';
import 'view/Settings/settings_screen.dart';
import 'view/ChangeUsername/change_username.dart';
import 'view/Timeline/timeline_screen.dart';
import 'view/MyProfile/my_profile_screen.dart';
import 'view/OtherUsers/other_users_screen.dart';
import 'view/ChangePassword/change_password.dart';
import 'view/ForgotPassword/forgot_password.dart';
import 'view/AllMessages/all_messages_screen.dart';
import 'view/AnotherUser/another_user_screen.dart';
import 'view/MessageDetail/message_detail_screen.dart';

class Routing {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MapScreen());
      case signInRoute:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case messsagesRoute:
        return MaterialPageRoute(builder: (_) => AllMessagesScreen());
      case anotherUserRoute:
        return MaterialPageRoute(builder: (_) => AnotherUserScreen());
      case changeUsernameRoute:
        return MaterialPageRoute(builder: (_) => ChangeUsernameScreen());
      case changePasswordRoute:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case messageDetailRoute:
        return MaterialPageRoute(builder: (_) => MessageDetailScreen());
      case myProfileRoute:
        return MaterialPageRoute(builder: (_) => MyProfileScreen());
      case otherUsersRoute:
        return MaterialPageRoute(builder: (_) => OtherUsersScreen());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case timelineRoute:
        return MaterialPageRoute(builder: (_) => TimelineScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                'Ters giden birşeyler oldu\nMuhtemelen route ismi yanlış.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
    }
  }
}

const String homeRoute = '/map';
const String signInRoute = '/signIn';
const String signUpRoute = '/signUp';
const String messsagesRoute = '/messages';
const String anotherUserRoute = '/anotherUser';
const String changeUsernameRoute = '/changeUsername';
const String changePasswordRoute = '/changePassword';
const String forgotPasswordRoute = '/forgotPassword';
const String messageDetailRoute = '/messageDetails';
const String myProfileRoute = '/myProfile';
const String otherUsersRoute = '/otherUsers';
const String settingsRoute = '/settings';
const String timelineRoute = '/timeline';
