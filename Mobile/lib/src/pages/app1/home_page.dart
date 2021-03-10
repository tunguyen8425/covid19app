import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthpro/src/model/data.dart';
import 'package:healthpro/src/model/hospital.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/BottomNavigationBar/bootom_navigation_bar.dart';
import 'package:healthpro/src/wigets/hospital_icon.dart';
import 'package:healthpro/src/wigets/hospital_card.dart';
import 'package:healthpro/src/wigets/title_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String apiUrl = "https://healthpro-server.herokuapp.com/covid";
  bool isVN = true;
  Future<List<dynamic>> fetchUsers() async {

    var result = await http.get(apiUrl);
    return json.decode(result.body);
  }

  var _hospitals;
  @override
  void initState() {
    _getThingsOnStartup().then((value){
    });
    super.initState();
  }
  Future _getThingsOnStartup() async {
    final prefs = await SharedPreferences.getInstance();
    final key = '_saveToken';
    final value = prefs.getString(key) ?? 0;
    String url = "http://healthpro-server.herokuapp.com/api/hospitals";
    var reponse = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = json.decode(reponse.body);
    print(data);
    setState(() {
      _hospitals = data;
    });
  }

  Widget _covidWidget() {
    return Container(
      width: AppTheme.fullWidth(context),
      height: 50,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox.fromSize(
                    size: Size(110, 30), // button width and height
                    child: Material(
//                      color: Colors.red, // button color
                      child: InkWell(
                          splashColor: Colors.blue, // splash color
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () { _toggleVN(true); }, // button pressed
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/vietnam.png",
                              ),
                              SizedBox(width: 7),
                              Text(
                                'Vietnam',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: (isVN)?TextDecoration.underline:TextDecoration.none,
                                    fontSize: 16,
                                    color: (isVN)?Colors.blue:Colors.black
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox.fromSize(
                    size: Size(95, 30), // button width and height
                    child: Material(
//                      color: Colors.red, // button color
                      child: InkWell(
                          splashColor: Colors.blue, // splash color
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () { _toggleVN(false); },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/world.png",
                              ),
                              SizedBox(width: 7),
                              Text(
                                'World',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    decoration: (isVN)?TextDecoration.none:TextDecoration.underline,
                                    color: (isVN)?Colors.black:Colors.blue
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ]
            ),


          ]
      ),

    );
  }
  void _toggleVN(checkVN) {
    setState(() {
      if((checkVN)&&(!isVN)){
        isVN = true;
      }else if((!checkVN)&&(isVN)){
        isVN = false;
      }
    });
  }

  Widget _hospitalWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * 0.95,
      child: (_hospitals != null)?GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 10/7,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          scrollDirection: Axis.horizontal,
          children: _hospitals['hospitals']
              .map<Widget>((x) => HospitalCard(
            hospital: x,
          ))
              .toList()):SizedBox(height: 20),
    );
  }

  Widget _staticWidget() {
    return
      Container(
        width: AppTheme.fullWidth(context),
        height: 150,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FutureBuilder<List<dynamic>>(
                future: fetchUsers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    if(isVN){
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
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
                                              text: snapshot.data[0]['confirmed'],
                                              fontSize: 17,
                                              color: Colors.orange,
                                            ),
                                            TitleText(
                                              text: "Confirmed",
                                              fontSize: 14,
                                              color: Colors.orange,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
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
                                              text: snapshot.data[0]['recovered'],
                                              fontSize: 17,
                                              color: Colors.green,
                                            ),
                                            TitleText(
                                              text: "Recovered",
                                              fontSize: 14,
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
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
                                              text: snapshot.data[0]['deaths'],
                                              fontSize: 17,
                                              color: Colors.red,
                                            ),
                                            TitleText(
                                              text: "Deaths",
                                              fontSize: 14,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 8, bottom: 8),
                                    child: TitleText(
                                      text: "",
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 8, bottom: 8),
                                    child: TitleText(
                                      text: "Sources: BYT",
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ]
                            ),
                          ]
                      );
                    } else {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
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
                                              text: snapshot.data[1]['confirmed'],
                                              fontSize: 17,
                                              color: Colors.orange,
                                            ),
                                            TitleText(
                                              text: "Confirmed",
                                              fontSize: 14,
                                              color: Colors.orange,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
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
                                              text: snapshot.data[1]['recovered'],
                                              fontSize: 17,
                                              color: Colors.green,
                                            ),
                                            TitleText(
                                              text: "Recovered",
                                              fontSize: 14,
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
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
                                              text: snapshot.data[1]['deaths'],
                                              fontSize: 17,
                                              color: Colors.red,
                                            ),
                                            TitleText(
                                              text: "Deaths",
                                              fontSize: 14,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 8, bottom: 8),
                                    child: TitleText(
                                      text: "",
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 8, bottom: 8),
                                    child: TitleText(
                                      text: "Sources: BYT",
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ]
                            ),
                          ]
                      );
                    }

                  }else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox.fromSize(
                      size: Size(AppTheme.fullWidth(context) - 40, 50), // button width and height
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.orange, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // splash color
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          onTap: () {
                            Navigator.of(context).pushNamed('/covid_detail');
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: "Medical declaration".toUpperCase(),
                                fontSize: 17,
                                color: Colors.white,
                              ), // icon
                            ],
                          ),
                        ),
                      ),
                    )
                  ]
              ),
            ]
        ),

      );
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
              child : TitleText(
                text: "Covid-19 statistic",
                fontSize: 20,
              ),
            ),
            _covidWidget(),
            _staticWidget(),
            Divider(
              color: Colors.black26,
              indent: 20.0,
              endIndent: 20.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child : TitleText(
                text: "Hospital highlights",
                fontSize: 20,
              ),
            ),
            _hospitalWidget(),
            SizedBox(height: 75),
          ],
        )
    );
  }
}
