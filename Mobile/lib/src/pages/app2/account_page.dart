import 'package:flutter/material.dart';
import 'package:healthpro/src/model/data.dart';
import 'package:healthpro/src/model/survey.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/title_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<AccountPage> {
  String _token;
  @override
  void initState() {
    _getThingsOnStartup().then((value){
      print('Async done');
      print(_token);
    });
    super.initState();
  }

  Future _getThingsOnStartup() async {
    super.initState();
    final prefs = await SharedPreferences.getInstance();
    final key = '_saveToken';
    final value = prefs.getString(key) ?? 0;
    setState(() {
      _token = value;
    });
  }

  Widget _menu(context) {
    var temp;
    _read() async {
      final prefs = await SharedPreferences.getInstance();
      final key = 'my_int_key';
      final value = prefs.getString(key) ?? 0;
      temp = value;
      print('read: $value');
    }
    return Column(
        children: <Widget>[
          Container(
            width:  AppTheme.fullWidth(context) * 0.5,
            decoration: BoxDecoration(
//              color: LightColor.background,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset("assets/user.png",fit: BoxFit.fill),
              ],
            ),
          ),
//          SizedBox(height: 30),
//          Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Container(
//                  width: 100,
//                  height: 75,
//                  decoration: BoxDecoration(
//                    color: LightColor.background,
//                    borderRadius: BorderRadius.all(Radius.circular(10)),
//                    boxShadow: <BoxShadow>[
//                      BoxShadow(
//                          color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
//                    ],
//                  ),
//                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                  child: Stack(
//                    alignment: Alignment.center,
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          Icon(
//                            Icons.info,
//                            color: LightColor.black,
//                          ),
//                          TitleText(
//                            text: "Info",
//                            fontSize: 14,
//                            color: Colors.orange,
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  width: 100,
//                  height: 75,
//                  decoration: BoxDecoration(
//                    color: LightColor.background,
//                    borderRadius: BorderRadius.all(Radius.circular(10)),
//                    boxShadow: <BoxShadow>[
//                      BoxShadow(
//                          color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
//                    ],
//                  ),
//                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                  child: Stack(
//                    alignment: Alignment.center,
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          Icon(
//                            Icons.settings,
//                            color: LightColor.black,
//                          ),
//                          TitleText(
//                            text: "Settings",
//                            fontSize: 14,
//                            color: Colors.green,
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  width: 100,
//                  height: 75,
//                  decoration: BoxDecoration(
//                    color: LightColor.background,
//                    borderRadius: BorderRadius.all(Radius.circular(10)),
//                    boxShadow: <BoxShadow>[
//                      BoxShadow(
//                          color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
//                    ],
//                  ),
//                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                  child: Stack(
//                    alignment: Alignment.center,
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          Icon(
//                            Icons.photo,
//                            color: LightColor.black,
//                          ),
//                          TitleText(
//                            text: "Photo",
//                            fontSize: 14,
//                            color: Colors.red,
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              ]
//          ),
          SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _token == '0'?Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/register');
                      print("abc");
//          setState(() {
//            // model.isSelected = !model.isSelected;
//            //   AppData.productList.forEach((x) {
//            //     if (x.id == model.id && x.name == model.name) {
//            //       return;
//            //     }
//            //     x.isSelected = false;
//            //   });
//            //   var m = AppData.productList
//            //       .firstWhere((x) => x.id == model.id && x.name == model.name);
//            //   m.isSelected = !m.isSelected;
//          });
                    },// handle your onTap here
                    child: Container(
                      width: 100,
                      height: 75,
                      decoration: BoxDecoration(
                        color: LightColor.background,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TitleText(
                                text: "Register",
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ):Material(
                  child: SizedBox(height: 0),
                ),
                _token == '0'?Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
//                      print("abc");
                      _read();
//          setState(() {
//            // model.isSelected = !model.isSelected;
//            //   AppData.productList.forEach((x) {
//            //     if (x.id == model.id && x.name == model.name) {
//            //       return;
//            //     }
//            //     x.isSelected = false;
//            //   });
//            //   var m = AppData.productList
//            //       .firstWhere((x) => x.id == model.id && x.name == model.name);
//            //   m.isSelected = !m.isSelected;
//          });
                    },// handle your onTap here
                    child: Container(
                      width: 100,
                      height: 75,
                      decoration: BoxDecoration(
                        color: LightColor.background,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TitleText(
                                text: "Login",
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ):Material(
                  child: SizedBox(height: 0),
                ),
                _token != '0'?Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/');
                      _logOut();
//          setState(() {
//            // model.isSelected = !model.isSelected;
//            //   AppData.productList.forEach((x) {
//            //     if (x.id == model.id && x.name == model.name) {
//            //       return;
//            //     }
//            //     x.isSelected = false;
//            //   });
//            //   var m = AppData.productList
//            //       .firstWhere((x) => x.id == model.id && x.name == model.name);
//            //   m.isSelected = !m.isSelected;
//          });
                    },// handle your onTap here
                    child: Container(
                      width: 100,
                      height: 75,
                      decoration: BoxDecoration(
                        color: LightColor.background,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TitleText(
                                text: "Logout",
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ):Material(
                  child: SizedBox(height: 0),
                ),
              ]
          ),
        ]
    );
  }
  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    final key = '_saveToken';
    final value = '0';
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _menu(context),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
