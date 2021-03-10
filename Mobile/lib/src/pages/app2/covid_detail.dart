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

class CovidDetailPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<CovidDetailPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final dateController = TextEditingController();
  final nationalController = TextEditingController();
  final insurenceController = TextEditingController();

  @override
  void initState() {
    _getThingsOnStartup().then((value){
      print('Async done');
    });
    super.initState();
  }


  String _gender = '1';
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
      _gender =  data['data']['gender'];
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    dateController.dispose();
    nationalController.dispose();
    insurenceController.dispose();
    super.dispose();
  }


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
      height: 500,
      child: ListView(
        children: <Widget>[
          new TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your first and last name',
              labelText: 'Name',
            ),
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
            controller: addressController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.location_city),
              hintText: 'Address',
              labelText: 'Address',
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.location_city),
              hintText: 'City',
              labelText: 'City',
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            controller: dateController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.date_range),
              hintText: 'Date of Birth',
              labelText: 'Date of Birth',
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            controller: nationalController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.credit_card),
              hintText: 'National ID',
              labelText: 'National ID',
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            controller: insurenceController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.credit_card),
              hintText: 'Insurance ID',
              labelText: 'Insurance ID',
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          final key = '_saveToken';
          final value = prefs.getString(key) ?? 0;
          String url = "http://healthpro-server.herokuapp.com/api/covid19";
          var reponse = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'name': nameController.text,
              'national_id': nationalController.text,
              'insurance_id': insurenceController.text,
              'date_of_birth': dateController.text,
              'gender': _gender,
              'city': cityController.text,
              'address': addressController.text,
              'phone': phoneController.text,
              'email': emailController.text,
            }),
          );
          var data = json.decode(reponse.body);
          if(data['status'] == 'success'){
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
