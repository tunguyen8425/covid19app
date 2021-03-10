import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthpro/src/model/survey.dart';
import 'package:healthpro/src/model/data.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/hospital_icon.dart';
import 'package:healthpro/src/wigets/title_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DirectDetailPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<DirectDetailPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void initState() {
    _getThingsOnStartup().then((value){
    });
    super.initState();
  }
  var _hospital;
  var _html;
  Future _getThingsOnStartup() async {
    final prefs = await SharedPreferences.getInstance();
    final key = '_currentHospital';
    final value = prefs.getString(key) ?? 0;
    String url = "http://healthpro-server.herokuapp.com/api/hospital/" + value.toString();
    var respon = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = json.decode(respon.body);
    var _des = data['hospital']['map_address'].toString();
    var _current = await Geolocator().getCurrentPosition();

    var directUrl = 'https://maps.googleapis.com/maps/api/directions/json?origin=' + _current.latitude.toString() + ', ' + _current.longitude.toString() + '&destination=' + _des.split(",")[0] + ',' + _des.split(",")[1] + '&key=AIzaSyA8q3xptu2kqEvpuLSPGS_S0chVSAomCqg';

    try {
      final response = await http.get(directUrl);
      final int statusCode = response.statusCode;
      if (statusCode == 201 || statusCode == 200) {
        var directRes = json.decode(response.body);
//        print(directRes['routes'][0]['legs']);
        _html = """<h3>Start address: """ + directRes['routes'][0]['legs'][0]['start_address'] + """</h3>""";
        _html += """<h3>End address: """ + directRes['routes'][0]['legs'][0]['end_address'] + """</h3>""";
        _html += """<ul>""";
        for(final step in directRes['routes'][0]['legs'][0]['steps']){
          print(step['html_instructions']);
          _html += step['html_instructions'];
        }
        _html += """</ul>""";
      } else {
        throw Exception('Error');
      }
    } catch(e) {
      print(e.toString());
    }

    setState(() {
      _hospital = data;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLiked = true;
  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: _icon(Icons.arrow_back_ios,
                color: Colors.black54, size: 15, padding: 12, isOutLine: true),
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon,
      {Color color = LightColor.iconColor,
        double size = 20,
        double padding = 10,
        bool isOutLine = false}) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
        isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    );
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () async {
          Navigator.of(context).pushNamed('/');
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'Done',
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  _appBar(),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: (_html != null)?Html(
                      data: _html,
                    ):SizedBox(),
                  ),
                  SizedBox(height: 20),
                  _submitButton(context),
                  SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
