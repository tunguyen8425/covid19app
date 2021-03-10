import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthpro/src/model/survey.dart';
import 'package:healthpro/src/model/data.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/hospital_icon.dart';
import 'package:healthpro/src/wigets/title_text.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HospitalDetailPage extends StatefulWidget {
  HospitalDetailPage({Key key}) : super(key: key);

  @override
  _HospitalDetailPageState createState() => _HospitalDetailPageState();
}

class _HospitalDetailPageState extends State<HospitalDetailPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    _getThingsOnStartup().then((value){
    });
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
         CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  var _hospital;
  Future _getThingsOnStartup() async {
    final prefs = await SharedPreferences.getInstance();
    final key = '_currentHospital';
    final value = prefs.getString(key) ?? 0;
    print(value);
    String url = "http://healthpro-server.herokuapp.com/api/hospital/" + value.toString();
    var reponse = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = json.decode(reponse.body);
    setState(() {
      _hospital = data;
    });
  }

  @override
  void dispose() {
    controller.dispose();
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
          InkWell(
            onTap: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
            child: _icon(isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? LightColor.red : LightColor.lightGrey,
                size: 15,
                padding: 12,
                isOutLine: true),
          )
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

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          TitleText(
            text: "AIP",
            fontSize: 160,
            color: LightColor.lightGrey,
          ),
          Image.asset('assets/hospital.jpg')
        ],
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              AppData.showThumbnailList.map((x) => _thumbnail(x)).toList()),
    );
  }

  Widget _thumbnail(String image) {
    return AnimatedBuilder(
        animation: animation,
        //  builder: null,
        builder: (context, child) => AnimatedOpacity(
              opacity: animation.value,
              duration: Duration(milliseconds: 500),
              child: child,
            ),
        child: Container(
          height: 40,
          width: 50,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: LightColor.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(13),
            ),
            // color: Theme.of(context).backgroundColor,
          ),
          child: Image.asset("assets/hospital.jpg"),
        ));
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return (_hospital != null)?Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: TitleText(
                      text: _hospital['hospital']['name'].toString().toUpperCase(),
                      fontSize: 25
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
//                _hour(),
//                SizedBox(
//                  height: 20,
//                ),
                _address(),
                SizedBox(
                  height: 20,
                ),
//                _availableDepartment(),
//                SizedBox(
//                  height: 20,
//                ),
                _description(),
              ],
            ),
          ),
        ):SizedBox(height: 5);
      },
    );
  }
  Widget _hour() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Business hours",
          fontSize: 14,
        ),
        SizedBox(height: 5),
        Text(
            "Open all day"
        ),
      ],
    );
  }
  Widget _address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Address",
          fontSize: 14,
        ),
        SizedBox(height: 5),
        Text(
            _hospital['hospital']['address'].toString(),
        ),
      ],
    );
  }
  Widget _availableDepartment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Department",
          fontSize: 14,
        ),
        SizedBox(height: 5),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _departmentWidget("Surgery"),
                _departmentWidget("Internal medicine"),
                _departmentWidget("Plastic surgery"),
                _departmentWidget("Orthopedic surgery"),
                _departmentWidget("Thoracic surgery"),
                _departmentWidget("Nuclear medicine"),
                _departmentWidget("Allergy"),
              ],
            ),
        ),
      ],
    );
  }
  Widget _departmentWidget(String text,
      {Color color = LightColor.iconColor, bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color:
            isSelected ? LightColor.orange : Theme.of(context).backgroundColor,
      ),
      child: TitleText(
        text: text,
        fontSize: 16,
        color: isSelected ? LightColor.background : LightColor.titleTextColor,
      ),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Description",
          fontSize: 14,
        ),
        SizedBox(height: 5),
        Text(
          _hospital['hospital']['description'].toString(),
        ),
      ],
    );
  }

  Column _flotingButton() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
//          SizedBox.fromSize(
//            size: Size(60, 60), // button width and height
//            child: ClipOval(
//              child: Material(
//                color: Colors.orange, // button color
//                child: InkWell(
//                  splashColor: Colors.blue, // splash color
//                  onTap: () {}, // button pressed
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(
//                        Icons.directions,
//                        color: Colors.white,
//                      ), // icon
////                            Text("Call"), // text
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          SizedBox.fromSize(
//            size: Size(60, 60), // button width and height
//            child: ClipOval(
//              child: Material(
//                color: Colors.green, // button color
//                child: InkWell(
//                  splashColor: Colors.blue, // splash color
//                  onTap: () {}, // button pressed
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(
//                        Icons.call,
//                        color: Colors.white,
//                      ), // icon
////                            Text("Call"), // text
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _flotingButton(),
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
                  _productImage(),
                  _categoryWidget(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }
}
