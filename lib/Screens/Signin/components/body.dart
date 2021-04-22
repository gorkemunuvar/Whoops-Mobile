import 'dart:convert';
import 'background.dart';
import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_on_map/services/storage.dart';
import 'package:notes_on_map/services/Networking.dart';
import 'package:notes_on_map/components/button_component.dart';
import 'package:notes_on_map/components/text_field_component.dart';

import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  Future<bool> _isClientHasToken() async {
    Storage tokenStorage = Storage();
    Map<String, String> tokens = await tokenStorage.readTokens();

    return tokens['status'] == 'has_token' ? false : true;
  }

  void _handleStorage() async {
    //Storage'da access ve resfresh token var mı?

    //Eğer token öncede kayıtlı ise expire olmuş mu?

    //Expire olmuş ise refresh token ile yeniden access token al.

    //Gelen yeni access token'ı storage'a yaz.

    //Eğer token expire olmamışsa Home Page'e yönlendir.

    //Önceden bir token kaydedilmemişse kullanıcı bilgilerini al.

    //Post(email, password) isteği gönder.

    //İşlem başarılı ise dönen tokenları al.

    //Dönen token'ları storage'a kaydet.

    //Home Page'e yönlendir.
  }

  Future<http.Response> _makePostRequest(String email, String password) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    http.Response response = await Networking.post('$kServerUrl/signin', body);

    return response;
  }

  String _emailInput = '';
  String _passwordInput = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //If it returns true, apply the logic.
    _isClientHasToken().then((value) {
      print(value);
    });

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
                onPressed: () async {
                  http.Response response = await _makePostRequest(
                    _emailInput,
                    _passwordInput,
                  );

                  //If user logs in correctly
                  if (response.statusCode == 201) {
                    //Get tokens
                    Map<String, dynamic> tokens =
                        json.decode(response.body) as Map;

                    print(tokens['access_token']);
                    print(tokens['refresh_token']);

                    Storage storage = Storage();
                    storage
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
