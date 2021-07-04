import 'routing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/user_provider.dart';
import 'provider/whoops_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WhoopsProvider>(
          create: (context) => WhoopsProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whoops',
        onGenerateRoute: Routing.generateRoute,
        theme: ThemeData(
          canvasColor: Colors.transparent,
        ),
        initialRoute: '/signIn',
      ),
    );
  }
}
