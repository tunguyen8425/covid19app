import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthpro/src/model/data.dart';
import 'package:healthpro/src/model/hospital.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/title_text.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String _gender = '1';
  int _radioValue = 1;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 1:
          _gender = '1';
          break;
        case 2:
          _gender = '2';
          break;
        case 3:
          _gender = '3';
          break;
      }
    });
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
                    controller: nameController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.account_circle),
                      hintText: 'Enter a Name',
                      labelText: 'Name',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter a email address',
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
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TitleText(
                        text: "Gender",
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      Radio(
                        activeColor: Colors.green,
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      Text("Male"),
                      Radio(
                        activeColor: Colors.green,
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      Text("Female"),
                      Radio(
                        activeColor: Colors.green,
                        value: 3,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      Text("Others")
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter phone number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 30),
                  FlatButton(
                      onPressed: () async {
                        String urL = "http://healthpro-server.herokuapp.com/api/auth/register";
                        var reponse = await http.post(
                          urL,
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'name': nameController.text,
                            'email': emailController.text,
                            'gender' : _gender,
                            'phone' : phoneController.text,
                            'password': passwordController.text,
                            'password_confirmation': passwordController.text,
                          }),
                        );
//                        print(_result);
                        var data = json.decode(reponse.body);
                        if(data.toString().contains("success")){
                          Navigator.of(context).pushNamed('/login');
                        }
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: LightColor.orange,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        width: AppTheme.fullWidth(context) * .7,
                        child: TitleText(
                          text: 'Register',
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
