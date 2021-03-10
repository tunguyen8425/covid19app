import 'package:flutter/material.dart';
import 'package:healthpro/src/model/data.dart';
import 'package:healthpro/src/pages/app1/home_page.dart';
import 'package:healthpro/src/pages/app2/form_page.dart';
import 'package:healthpro/src/pages/app2/account_page.dart';
import 'package:healthpro/src/pages/app1/map_page.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/BottomNavigationBar/bootom_navigation_bar.dart';
import 'package:healthpro/src/wigets/hospital_icon.dart';
import 'package:healthpro/src/wigets/hospital_card.dart';
import 'package:healthpro/src/wigets/title_text.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;
  int pickPage = 0;
  Widget _appBar() {
    return Container(
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
      padding: AppTheme.padding,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                child: Container(
                  width: 120.0,
                  child: Image.asset("assets/user.png",fit: BoxFit.fill),
                ),
              ),

//              Row(
//                children: <Widget>[
//                  Icon(
//                    Icons.location_on,
//                    color: LightColor.black,
//                  ),
//                  SizedBox(width: 3),
//                  Row(
//                    children: <Widget>[
//                      Text('Hồ Chí Minh'),
//                      Icon(
//                        Icons.keyboard_arrow_down,
//                        color: LightColor.black,
//                      ),
//                    ],
//                  ),
//                ],
//              )
            ],
          ),
          _title(),
        ]
      ),
    );
  }
  Widget _search() {
    return Expanded(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: LightColor.lightGrey.withAlpha(100),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search for hospital",
              hintStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
              prefixIcon: Icon(Icons.search, color: Colors.black54)),
        ),
      ),
    );
  }
  Widget _title() {
    return Container(
      child: Row(
            children: <Widget>[
              isHomePageSelected
                  ? SizedBox(): SizedBox(),
            ],
        ),
    );
  }

  void onBottomIconPressed(int index) {
    pickPage = index;
    if (index == 0) {
      setState(() {
        isHomePageSelected = true;
      });
    } else {
      setState(() {
        isHomePageSelected = false;
      });
    }
  }

  Widget _pickPage() {
    switch (pickPage) {
      case 0:
        return MyHomePage();
        break;
      case 1:
        return Align(
            alignment: Alignment.center,
            child:MapPage()
        );
        break;
      case 2:
        return Align(
            alignment: Alignment.center,
            child:FormPage()
        );
        break;
      case 3:
        return Align(
            alignment: Alignment.center,
            child:AccountPage()
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xfffbfbfb),
                    Color(0xfff7f7f7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    isHomePageSelected
                        ? _appBar(): SizedBox(),
                    SizedBox(height: 6),
                    Expanded(
                        child:AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          switchInCurve: Curves.easeInToLinear,
                          switchOutCurve: Curves.easeOutBack,
                          child: _pickPage(),
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: CustomBottomNavigationBar(
                  onIconPresedCallback: onBottomIconPressed,
                ))
          ],
        ),
      ),
    );
  }
}
