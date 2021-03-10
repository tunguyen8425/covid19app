import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthpro/src/model/data.dart';
import 'package:healthpro/src/model/survey.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/title_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FormPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<FormPage> {
  String _token;
  var _survey;
  @override
  void initState() {
    _getThingsOnStartup().then((value){
//      print('Async done');
//      print(_token);
      if(_token == '0'){
        Navigator.of(context).pushNamed('/login');
      }
    });
    super.initState();
  }
  Future _getThingsOnStartup() async {
    super.initState();
    final prefs = await SharedPreferences.getInstance();
    final key = '_saveToken';
    final value = prefs.getString(key) ?? 0;

    String url = "http://healthpro-server.herokuapp.com/api/surveys_list";
    var reponse = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'Bearer ' + value
      },
    );
    var data = json.decode(reponse.body);
    print(data);
    setState(() {
      _token = value;
      _survey = data;
    });
  }
  Widget _cartItems() {
    return (_survey != null)?Column(children: _survey['surveys'].map<Widget>((x) => _item(x)).toList()):SizedBox(height: 20);
  }

  Widget _item(Map<String, dynamic> model) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: LightColor.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Image.asset(
                    "assets/virus.png",
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListTile(
                  title: TitleText(
                    text: model['title'].toString(),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  trailing: Container(
                    width: 80,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: LightColor.lightGrey.withAlpha(150),
                        borderRadius: BorderRadius.circular(10)),
                    child: TitleText(
                      text: model['created_at'].toString().substring(0, model['created_at'].indexOf(' ')),
                      fontSize: 12,
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/form_detail');
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'New form',
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _cartItems(),
            Divider(
              thickness: 1,
              height: 70,
            ),
            SizedBox(height: 20),
            _submitButton(context),
          ],
        ),
      ),
    );
  }
}
