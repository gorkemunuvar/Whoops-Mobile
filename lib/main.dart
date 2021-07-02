import 'routing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_token_provider.dart';
import 'providers/whoops_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthTokenProvider>(
          create: (context) => AuthTokenProvider(),
        ),
        ChangeNotifierProvider<WhoopsProvider>(
          create: (context) => WhoopsProvider(),
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
