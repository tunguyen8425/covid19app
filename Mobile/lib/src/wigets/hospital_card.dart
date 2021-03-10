import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthpro/src/model/data.dart';
import 'package:healthpro/src/model/hospital.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/title_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HospitalCard extends StatefulWidget {
  final Map<String, dynamic> hospital;
  HospitalCard({Key key, this.hospital}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<HospitalCard> {
  Map<String, dynamic> model;
  var _far;
  @override
  void initState() {
    super.initState();
    model = widget.hospital;
    getFar();
  }
  void getFar() async {
    var _location = await Geolocator().getCurrentPosition();
    var des = model['map_address'].toString();
    var url = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=' + _location.latitude.toString() + ', ' + _location.longitude.toString() + '&destinations=' + des.split(",")[0] + ',' + des.split(",")[1] + '&key=AIzaSyA8q3xptu2kqEvpuLSPGS_S0chVSAomCqg';
    print(url);
    try {
      final response =
      await http.get(url);

      final int statusCode = response.statusCode;

      if (statusCode == 201 || statusCode == 200) {
        var responseBody = json.decode(response.body);
        if((responseBody['rows'] != null) && (responseBody['rows'][0]['elements'] != null)){
          String url_far = "http://healthpro-server.herokuapp.com/api/hospital/" + model['id'].toString() + "/far";

          var reponse = await http.put(
            url_far,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'far': responseBody['rows'][0]['elements'][0]['distance']['value'].toString(),
            }),
          );
          var data = json.decode(reponse.body);
          print(url_far);
          setState(() {
            _far = responseBody['rows'][0]['elements'][0]['distance']['value'] / 1000;
          });
        }
      } else {
        throw Exception('Error');
      }
    } catch(e) {
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        final key = '_currentHospital';
        prefs.setString(key, model['id'].toString());
        Navigator.of(context).pushNamed('/hospital_detail');
      },
      child: Container(
        decoration: BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0, // has the effect of softening the shadow
              spreadRadius: 0.0, // has the effect of extending the shadow
              offset: Offset(
                3.0, // horizontal, move right 10
                3.0, // vertical, move down 10
              ),
            )
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: LightColor.orange.withAlpha(40),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Container(
                        child: Container(
                          constraints: new BoxConstraints.expand(
                            height: 180,
                          ),
                          alignment: Alignment.topRight,
                          padding: new EdgeInsets.only(top: 8.0, right: 8.0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(
                                "assets/hospital.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
//                          child: new Text(
//                              model.far.toString() + "km",
//                              style: new TextStyle(
//                                fontWeight: FontWeight.bold,
//                                color: Colors.white,
//                                fontSize: 10.0,
//                                backgroundColor: Colors.black38
//                              )
//                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 5),
                Container(
                  height: 100,
                  child: Align(
                    alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TitleText(
                          text: model['name'].toString().toUpperCase(),
                          fontSize: 16,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
//                          child : Text(
//                            model['name'].toString(),
//                            style: TextStyle(fontSize: 12),
//                          ),
                        ),

                      ],
                    ),

                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox.fromSize(
                      size: Size(50, 50), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.red, // button color
                          child: InkWell(
                            splashColor: Colors.blue, // splash color
                            onTap: () {}, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ), // icon
//                            Text("Call"), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size(50, 50), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.orange, // button color
                          child: InkWell(
                            splashColor: Colors.blue, // splash color
                            onTap: () async {
                              final prefs = await SharedPreferences.getInstance();
                              final key = '_currentHospital';
                              prefs.setString(key, model['id'].toString());
                              Navigator.of(context).pushNamed('/direct_detail');
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.directions,
                                  color: Colors.white,
                                ), // icon
//                            Text("Call"), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size(100, 50), // button width and height
                      child: Material(
                        color: Colors.green, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // splash color
                          onTap: () {}, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: (_far != null)?_far.toStringAsFixed(2)+"km":(int.parse(model['far']) / 1000).toStringAsFixed(2) + "km",
                                fontSize: 10,
                                color: Colors.white,
                              ), // icon
//                            Text("Call"), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
