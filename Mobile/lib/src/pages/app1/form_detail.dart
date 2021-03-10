import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthpro/src/model/survey.dart';
import 'package:healthpro/src/model/data.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/hospital_icon.dart';
import 'package:healthpro/src/wigets/title_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FormDetailPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<FormDetailPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void initState() {
    _getThingsOnStartup().then((value){
      print('Async done');
    });
    super.initState();
  }

  Future _getThingsOnStartup() async {
    super.initState();
    final prefs = await SharedPreferences.getInstance();
    final key = '_saveToken';
    final value = prefs.getString(key) ?? 0;

    String url = "http://healthpro-server.herokuapp.com/api/auth/user";
    var reponse = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'Bearer ' + value
      },
    );

    var data = json.decode(reponse.body);
    print(data['data']['id']);
    prefs.setString('_id', data['data']['id'].toString());

    setState(() {
      nameController.text = data['data']['name'];
      phoneController.text = data['data']['phone'];
      emailController.text = data['data']['email'];
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
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

  String _symptom = 'Headache';
  int _radioSymptom = 1;
  void _handleRadioSymptomChange(int value) {
    setState(() {
      _radioSymptom = value;
      switch (_radioSymptom) {
        case 1:
          _symptom = 'Headache';
          break;
        case 2:
          _symptom = 'Backache';
          break;
        case 3:
          _symptom = 'Cough';
          break;
        case 4:
          _symptom = 'Fever';
          break;
        case 5:
          _symptom = 'Sore throat';
          break;
      }
    });
  }

  bool _headache = false;
  bool _backache = false;
  bool _cough = false;
  bool _fever = false;
  bool _sorethroat = false;
  void _onHeadache(bool newValue) => setState(() {
    _headache = newValue;
  });
  void _onBackache(bool newValue) => setState(() {
    _backache = newValue;
  });
  void _onCough(bool newValue) => setState(() {
    _cough = newValue;
  });
  void _onFever(bool newValue) => setState(() {
    _fever = newValue;
  });
  void _onSorethroat(bool newValue) => setState(() {
    _sorethroat = newValue;
  });

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

  Widget _formElement(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
          children: <Widget>[
            new TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter your first and last name',
                labelText: 'Name',
              ),
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
            new TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                icon: const Icon(Icons.phone),
                hintText: 'Enter a phone number',
                labelText: 'Phone',
              ),
              keyboardType: TextInputType.phone,
            ),
            new TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                icon: const Icon(Icons.email),
                hintText: 'Enter a email address',
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: "Symptom",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
                Checkbox(
                  activeColor: Colors.green,
                  value: _headache,
                  onChanged: _onHeadache,
                ),
                Text("Headache"),
                Checkbox(
                  activeColor: Colors.green,
                  value: _backache,
                  onChanged: _onBackache,
                ),
                Text("Backache"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Checkbox(
                  activeColor: Colors.green,
                  value: _cough,
                  onChanged: _onCough,
                ),
                Text("Cough"),
                Checkbox(
                  activeColor: Colors.green,
                  value: _fever,
                  onChanged: _onFever,
                ),
                Text("Fever"),
                Checkbox(
                  activeColor: Colors.green,
                  value: _sorethroat,
                  onChanged: _onSorethroat,
                ),
                Text("Sore throat"),
              ],
            ),
          ],
      )
    );
  }
  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () async {
          print(_symptom);
          final prefs = await SharedPreferences.getInstance();
          final key = '_saveToken';
          final value = prefs.getString(key) ?? 0;
          String url = "http://healthpro-server.herokuapp.com/api/survey";
          String _symptomStr = "";
          _symptomStr += (_headache == true)?"  Headache":"  ";
          _symptomStr += (_backache == true)?"  Backache":"  ";
          _symptomStr += (_cough == true)?"  Cough":"  ";
          _symptomStr += (_fever == true)?"  Fever":"  ";
          _symptomStr += (_sorethroat == true)?"  Sore throat":"  ";
          var reponse = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization' : 'Bearer ' + value
            },
            body: jsonEncode(<String, String>{
              'title': _symptomStr,
            }),
          );
          var data = json.decode(reponse.body);
          if(data['status'] == 'success'){
            Navigator.of(context).pushNamed('/');
          }

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
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'Submit',
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
              Column(
                children: <Widget>[
                  _appBar(),
                  SizedBox(height: 20),
                  _formElement(context),
                  SizedBox(height: 20),
                  _submitButton(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
