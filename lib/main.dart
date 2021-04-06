import 'routing.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'screens/Signin/signin_screen.dart';

/* void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whoops',
      onGenerateRoute: Routing.generateRoute,
      /* theme: ThemeData(
          //primaryColor: kPrimaryColor,
          // scaffoldBackgroundColor: Colors.white,
          //canvasColor: Colors.transparent,
          ), */
      home: SignInScreen(),
    );
  }
}
 */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whoops',
      home: SignInScreen(),
    );
  }
}
