import 'dart:io';
import 'dart:convert';
import 'background.dart';
import 'package:flutter/material.dart';
import 'package:whoops/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:whoops/controller/storage.dart';
import 'package:whoops/view/utils/button_component.dart';
import 'package:whoops/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whoops/view/utils/text_field_component.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _emailOrUsernameInput = '';
  String _passwordInput = '';

  bool _rememberMe;
  TextEditingController _passwordController;
  TextEditingController _emailOrUsernameController;

  @override
  initState() {
    super.initState();

    //Create a future builder to render after an async call
    _handleStorageTokens(context);
    getSharedPreferences();
    _emailOrUsernameController = TextEditingController();
    _passwordController = TextEditingController();
    _rememberMe = false;
  }

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
              // TextFieldComponent(
              //   hintText: 'Kullanıcı adı veya Email',
              //   onChanged: (value) {
              //     _emailOrUsernameInput = value;
              //   },
              // ),
              // TextFieldComponent(
              //   hintText: 'Şifre',
              //   obscureText: true,
              //   onChanged: (value) {
              //     _passwordInput = value;
              //   },
              // ),
              TextField(
                controller: _emailOrUsernameController,
                style: TextStyle(color: kPrimaryDarkColor),
                decoration: InputDecoration(
                  fillColor: kPrimaryDarkColor,
                  hintText: 'Kullanıcı adı veya Email',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: kPrimaryDarkColor),
                decoration: InputDecoration(
                  fillColor: kPrimaryDarkColor,
                  hintText: 'Şifre',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // _CheckBoxWidget(),
                      Checkbox(
                        checkColor: kPrimaryWhiteColor,
                        activeColor: kPrimaryDarkColor,
                        value: _rememberMe,
                        onChanged: (value) =>
                            setState(() => _rememberMe = value),
                      ),
                      Text(
                        'Beni Hatırla',
                        style: TextStyle(
                          color: kPrimaryDarkColor,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Text(
                      'Şifremi Unuttum',
                      style: TextStyle(
                        color: kPrimaryDarkColor,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    onTap: () =>
                        Navigator.pushNamed(context, '/forgotPassword'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ButtonComponent(
                text: 'Giriş',
                textColor: kPrimaryWhiteColor,
                backgroundColor: kPrimaryDarkColor,
                onPressed: () async {
                  if (_rememberMe)
                    await saveSharedPreferences(
                        _emailOrUsernameController.text);
                  _handleServerTokens(context);
                },
              ),
              SizedBox(height: 10),
              ButtonComponent(
                text: 'Kayıt Ol',
                textColor: kPrimaryDarkColor,
                backgroundColor: kPrimaryWhiteColor,
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');
                },
              ),
              SizedBox(height: 75),
              Center(
                child: Text(
                  'veya giriş yap',
                  style:
                      TextStyle(color: kPrimaryDarkColor, fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(height: 5),
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

  Future<Map<String, String>> _getTokens() async {
    Storage tokenStorage = Storage();
    Map<String, String> tokens = await tokenStorage.readTokens();

    return tokens;
  }

  Future<bool> _isTokenBlacklisted(String accessToken) async {
    Map<String, String> body = {'access_token': accessToken};

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    http.Response response = await http.post(
      '$kServerUrl/token/is_token_blacklisted',
      headers: headers,
      body: json.encode(body),
    );

    print('_isTokenBlacklisted() func. STATUS CODE = ${response.statusCode}');

    //200 means token is blacklisted
    //404 means token is not blacklisted
    if (response.statusCode == 200) return true;
    return false;
  }

  Future<bool> checkConnection() async {
    bool flag;

    try {
      final result = await InternetAddress.lookup('google.com');
      //This line means device is connected.
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) flag = true;
    } on SocketException catch (_) {
      flag = false;
    }

    return flag;
  }

  void _handleStorageTokens(BuildContext context) {
    _getTokens().then((value) async {
      //If user logged in before get the token from local storage
      if (value['status'] == 'has_token') {
        String accessToken = value['whoops_access_token'];
        String refreshToken = value['whoops_refresh_token'];

        print('Device has token.');
        print('Access Token: $accessToken');
        print('Refresh Token: $refreshToken');

        bool netConnectionState = await checkConnection();

        if (!netConnectionState) {
          print('There is no connection');
          return;
          //If devices has connection
        } else {
          print('There is connection');

          bool isTokenBlacklisted = await _isTokenBlacklisted(accessToken);

          if (isTokenBlacklisted) {
            print('Token was blacklisted.');

            //Do not let user login
            print('NOT LOGGED IN');
            return;
          } else {
            print('Token was NOT blacklisted');
          }

          //Check if the tokens has expired
          // bool isTokenExpired = JwtDecoder.isExpired(accessToken);
          bool isTokenExpired = false;

          //Get a new  access token using refresh token
          if (isTokenExpired) {
            print('TOKEN EXPIRED');

            final headers = {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $refreshToken',
            };

            //send bearer to /token/refresh endpoint
            http.Response response = await http.post(
              '$kServerUrl/token/refresh',
              headers: headers,
            );

            if (response.statusCode == 200) {
              Map<String, dynamic> map = json.decode(response.body) as Map;

              accessToken = map['access_token'];

              //Save the new(refreshed) access token
              await Storage().saveAccessToken(accessToken);

              print('TOKEN REFRESHED');
            } else {
              print('Something went wrong while POST/token/refresh');
              print('Status Code: ${response.statusCode}');
              return;
            }
          }

          //Device has tokens anyway in this scope
          //Update tokens for AuthTokenProvider then.
          Provider.of<UserProvider>(context, listen: false)
              .updateAccessToken(accessToken);
          Provider.of<UserProvider>(context, listen: false)
              .updateRefreshToken(refreshToken);

          print('LOGGED IN');
          Navigator.pushNamed(context, '/map');
        }
      } else
        print('Device has not token.');
    });
  }

  void _handleServerTokens(BuildContext context) async {
    //Get email and password info from text fields
    // Map<String, String> body = {
    //   'email': _emailOrUsernameInput,
    //   'password': _passwordInput,
    // };
    Map<String, String> body = {
      'email': _emailOrUsernameController.text,
      'password': _passwordController.text,
    };

    //Make a post request with user info
    http.Response response = await http.post(
      '$kServerUrl/user/signin',
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    print(response.body);

    //If user logs in correctly
    if (response.statusCode == 201) {
      //Get access and refresh token from the server
      Map<String, dynamic> tokens = json.decode(response.body) as Map;

      //Save tokens to phone's local storage
      //And then whenever this screen is run, _handleStorageTokens() func.
      //will check the tokens and will forward to Home Screen without
      //asking for any info from the user.
      Storage()
          .saveTokens(
        tokens['access_token'],
        tokens['refresh_token'],
      )
          .then((value) {
        Provider.of<UserProvider>(context, listen: false)
            .updateAccessToken(tokens['access_token']);
        Provider.of<UserProvider>(context, listen: false)
            .updateRefreshToken(tokens['refresh_token']);

        print('LOGGED IN');
        Navigator.pushNamed(context, '/map');
      });
    } else if (response.statusCode == 401) {
      print('Wrong Credentials!');
    } else if (response.statusCode == 404) {
      print('User does not exist');
    } else {
      print('Something went wrong.');
      print('Status Code: ${response.statusCode}');
    }
  }

  Future<bool> saveSharedPreferences(String username) async {
    var shared = await SharedPreferences.getInstance();
    return shared.setString("whoopsUsername", username);
  }

  void getSharedPreferences() async {
    var shared = await SharedPreferences.getInstance();
    String value = shared.getString("whoopsUsername");
    if (value != null) _emailOrUsernameController.text = value;
  }
}

// class _CheckBoxWidget extends StatefulWidget {
//   @override
//   __CheckBoxWidgetState createState() => __CheckBoxWidgetState();
// }

// class __CheckBoxWidgetState extends State<_CheckBoxWidget> {
//   void _onRememberMeChanged(bool newValue) =>
//       setState(() => _rememberMe = newValue);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 24.0,
//       width: 24.0,
//       child: Checkbox(
//         checkColor: kPrimaryWhiteColor,
//         activeColor: kPrimaryDarkColor,
//         value: _rememberMe,
//         onChanged: _onRememberMeChanged,
//       ),
//     );
//   }
// }
