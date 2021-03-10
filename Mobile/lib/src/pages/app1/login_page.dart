import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthpro/src/model/data.dart';
import 'package:healthpro/src/model/hospital.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/title_text.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Material(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              child: ListView(
                padding: EdgeInsets.only(top: AppTheme.fullWidth(context)/2),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
//              color: LightColor.background,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset("assets/user.png",fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter a Email',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.security),
                      hintText: 'Enter password',
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  FlatButton(
                      onPressed: () async {
                        String urL = "http://healthpro-server.herokuapp.com/api/auth/login";
                        var reponse = await http.post(
                            urL,
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'email': usernameController.text,
                              'password': passwordController.text,
                            }),
                        );
                        Map<String, String> headers = reponse.headers;
                        String authorization = headers['authorization'];
                        if(authorization != null){
                          _logIn(authorization);
                          Navigator.of(context).pushNamed('/');
                        }
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: LightColor.orange,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        width: AppTheme.fullWidth(context) * .7,
                        child: TitleText(
                          text: 'Login',
                          color: LightColor.background,
                          fontWeight: FontWeight.w500,

                        ),
                      )
                  ),
//                  buildSubmitButton()
                ],
              ),
            ),
          ),
        )
    );
  }
}
_logIn(_token) async {
  final prefs = await SharedPreferences.getInstance();
  final key = '_saveToken';
  prefs.setString(key, _token);
}
