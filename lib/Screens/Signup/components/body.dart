import 'package:flutter/material.dart';
import 'package:notes_on_map/constants.dart';
import 'package:notes_on_map/components/text_field_component.dart';
import 'package:notes_on_map/Screens/SignUp/components/background.dart';
import 'package:notes_on_map/components/button_component.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  Future<http.Response> post(dynamic body) {
    return http.post(
      'https://3760c477f05f.ngrok.io/signup',
      body: json.encode(body),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
  }

  void _handleSignup(
    String email,
    String password,
    BuildContext context,
  ) async {
    dynamic body = {
      'email': email,
      'password': password,
    };

    //Parametreler ile  POST isteği yap
    http.Response response = await post(body);

    //Eğer başarılı ise Login Page' yönlendir
    if (response.statusCode == 201)
      Navigator.pushNamed(context, '/signIn');

    //Hatalı sonuç döner ise uyarı ver.
    else
      print('${response.statusCode}. Bir hata ile karşılaştınız.');
  }

  String _email = '';
  String _password = '';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _printEmailValue() {
    _email = _emailController.text;
  }

  _printPasswordValue() {
    _password = _passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _emailController.addListener(_printEmailValue);
    _passwordController.addListener(_printPasswordValue);

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
              Text(
                'Kayıt Ol',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: kPrimaryDarkColor,
                ),
              ),
              SizedBox(height: 20),
              TextFieldComponent(
                hintText: 'Email',
                controller: _emailController,
              ),
              TextFieldComponent(
                hintText: 'Şifre',
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 20),
              ButtonComponent(
                text: 'Kayıt Ol',
                textColor: kPrimaryWhiteColor,
                backgroundColor: kPrimaryDarkColor,
                onPressed: () {
                  _handleSignup(_email, _password, context);
                },
              ),
              SizedBox(height: 10),
              ButtonComponent(
                text: 'Giriş',
                textColor: kPrimaryDarkColor,
                backgroundColor: kPrimaryWhiteColor,
                onPressed: () {
                  Navigator.pushNamed(context, '/signIn');
                },
              ),
              SizedBox(height: 75),
              Center(
                child: Text(
                  'ile kayıt ol',
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
