import 'dart:convert';
import 'background.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_on_map/services/storage.dart';
import 'package:notes_on_map/components/button_component.dart';
import 'package:notes_on_map/components/text_field_component.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Body extends StatelessWidget {
  Future<Map<String, String>> _getTokens() async {
    Storage tokenStorage = Storage();
    Map<String, String> tokens = await tokenStorage.readTokens();

    return tokens;
  }

  void _handleStorageTokens(BuildContext context) {
    _getTokens().then((value) {
      //If user logged in before get the token from local storage
      if (value['status'] == 'has_token') {
        String accessToken = value['whoops_access_token'];

        //Check if the tokens has expired
        bool isTokenExpired = JwtDecoder.isExpired(accessToken);

        //Get a new  access token using refresh token
        if (isTokenExpired) {
          String refreshToken = value['whoops_refresh_token'];

          final headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $refreshToken',
          };

          http
              //send bearer to /token/refresh endpoint
              .post('$kServerUrl/token/refresh', headers: headers)
              .then((value) async {
            http.Response response = value;
            if (response.statusCode == 200) {
              Map<String, dynamic> map = json.decode(response.body) as Map;

              //Save the new(refreshed) access token
              await Storage().saveAccessToken(map['access_token']);

              Navigator.pushNamed(context, '/map');
            }
          });
        }
        //If token has not expired, handle sign in
        else {
          Navigator.pushNamed(context, '/map');

          //Also add the token to states
          //It is going to be used for sending requests to
          //secure endpoints and loggin out functionality.
        }
      }
    });
  }

  void _handleServerTokens(BuildContext context) async {
    //Get email and password info from text fields
    Map<String, String> body = {
      'email': _emailInput,
      'password': _passwordInput,
    };

    //Make a post request with user info
    http.Response response = await http.post(
      '$kServerUrl/signin',
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

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
          .then((value) => Navigator.pushNamed(context, '/map'));
    } else if (response.statusCode == 401) {
      print('Wrong Credentials!');
    } else if (response.statusCode == 404) {
      print('User does not exist');
    } else {
      print('Something went wrong.');
      print('Status Code: ${response.statusCode}');
    }
  }

  String _emailInput = '';
  String _passwordInput = '';

  @override
  Widget build(BuildContext context) {
    _handleStorageTokens(context);

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
              TextFieldComponent(
                hintText: 'Email',
                onChanged: (value) {
                  _emailInput = value;
                },
              ),
              TextFieldComponent(
                hintText: 'Şifre',
                obscureText: true,
                onChanged: (value) {
                  _passwordInput = value;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _CheckBoxWidget(),
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
                onPressed: () {
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
                  'ile giriş yap',
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
}

class _CheckBoxWidget extends StatefulWidget {
  @override
  __CheckBoxWidgetState createState() => __CheckBoxWidgetState();
}

class __CheckBoxWidgetState extends State<_CheckBoxWidget> {
  bool rememberMe = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.0,
      width: 24.0,
      child: Checkbox(
        checkColor: kPrimaryWhiteColor,
        activeColor: kPrimaryDarkColor,
        value: rememberMe,
        onChanged: _onRememberMeChanged,
      ),
    );
  }
}
